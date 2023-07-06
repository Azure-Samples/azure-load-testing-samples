import io
import zipfile
from pathlib import Path
import pandas as pd
import requests
import configparser
import time
import uuid

from azure.identity import ClientSecretCredential
from azure.mgmt.loadtesting import LoadTestMgmtClient
from azure.developer.loadtesting import LoadTestRunClient
from azure.developer.loadtesting import LoadTestAdministrationClient
from azure.storage.blob import BlobClient
from azure.core.exceptions import HttpResponseError

config = configparser.ConfigParser()
config.read(r".\configFile.ini")
region_display = {"australiaeast": "Australia East",
                  "eastasia": "East Asia", "eastus": "East US", "uksouth": "UK South"}


def extract_and_update_results(test_run_response, test_run_id, location):
    """
    Download results Zip 
    Extract the Zip file
    Add a column to the results CSV file
    Save the updated CSV file

    Parameters
    ----------
    test_run_response : dict
        test run results

    Returns
    -------
    dict

    Raises
    ------
    TypeError
        If the test_run_response is not a dict 
    """
    if not isinstance(test_run_response, dict):
        raise TypeError("test_run_response must be a dictionary")

    results_zip_url = test_run_response['testArtifacts']['outputArtifacts']['resultFileInfo']['url']

    csv_file_path = Path("./testRunResults")
    engine_index = 1  # This sample test run uses only one engine. In case of multiple engines, iterate over the result CSV files from each engine

    zipfile.ZipFile(io.BytesIO(requests.get(
        results_zip_url).content)).extractall(csv_file_path)

    results_df = pd.read_csv(
        csv_file_path/f"engine{str(engine_index)}_results.csv")
    results_df["testRunName"] = test_run_response["displayName"]
    results_df["Region"] = region_display[location]

    csv_file_name = f"csvTestResults_{test_run_id}_testengine{str(engine_index)}.csv"
    results_df.to_csv(
        csv_file_path/csv_file_name,
        index=False,
        header=True,
    )
    return {"csv_file_path": csv_file_path, "csv_file_name": csv_file_name}


def create_resources(mgmtClient, regions):
    """
    Create a resource in each region 
    Get the resources details
    Append to a list

    Parameters
    ----------
    mgmtClient : LoadTestMgmtClient,
    regions: string    

    Returns
    -------
    list

    Raises
    ------
    HttpResponseError
        If resource creation or getting resource details fails 
    """

    resource_group = config["DEFAULT"]["resource_group"]
    loadtest_resource_name = config["DEFAULT"]["loadtest_resource_name"]
    try:
        for region in regions:
            resourceCreationPoller = mgmtClient.load_tests.begin_create_or_update(
                resource_group_name=resource_group,
                load_test_name=loadtest_resource_name+"-"+region,
                load_test_resource={"location": region},
                content_type="application/json")

        time.sleep(180)
        resources = []
        for region in regions:
            resource = mgmtClient.load_tests.get(
                resource_group_name=resource_group, load_test_name=loadtest_resource_name+"-"+region)
            if (resource.provisioning_state == "Succeeded"):
                resources.append(
                    {"name": resource.name, "data_plane_uri": resource.data_plane_uri, "location": resource.location})
            else:
                print("Resource creation failed")

    except HttpResponseError as e:
        print('Service responded with error: {}'.format(e.response.json()))

    return resources


def create_tests(credential, resources):
    """
    For each resources,
        Get LoadTestAdministrationClient 
        Create a test
        Upload test artifacts
        Add test ID to a dictionary

    Parameters
    ----------
    credential : ClientSecretCredential,
    resources: list

    Returns
    -------
    dict

    Raises
    ------
    HttpResponseError
        If the test creation or file upload fails 
    """
    tests = {}
    file_names = [config["DEFAULT"]["jmx_file"], config["DEFAULT"]
                  ["csv_file"], config["DEFAULT"]["jar_file"]]
    for resource in resources:
        test_id = str(uuid.uuid4())
        adminClient = LoadTestAdministrationClient(
            endpoint=resource['data_plane_uri'], credential=credential)
        try:
            result = adminClient.create_or_update_test(
                test_id,
                {
                    "description": "",
                    "displayName": "multi-region-load-test - "+resource['location'],
                    "loadTestConfig": {
                        "engineInstances": 1,
                        "splitAllCSVs": False,
                    },
                    "passFailCriteria": {
                        "passFailMetrics": {
                            "condition1": {
                                "clientmetric": "error",
                                "aggregate": "percentage",
                                "condition": ">",
                                "value": 5
                            },
                            "condition2": {
                                "clientmetric": "response_time_ms",
                                "aggregate": "avg",
                                "condition": ">",
                                "value": 1000,
                                "requestName": "Podcast page"
                            }
                        }
                    },
                    "environmentVariables": {
                        "webapp": "demo-podcastwebapp.azurewebsites.net"
                    }
                }
            )
            # print(result)
            # uploading files to the test
            for file_name in file_names:
                resultPoller = adminClient.begin_upload_test_file(
                    test_id, file_name, open(file_name, "rb"))
            tests[resource['location']] = test_id
        except HttpResponseError as e:
            print('Service responded with error: {}'.format(e.response.json()))

    return tests


def run_tests(credential, resources, tests):
    """
    For each resource
        Get the LoadTestRunClient
        Run the test
    
    For each resource 
        Poll for the test run completion 
        Wait for results file to be available
        Call the extract_and_update_results method to extract the results and add required columns
        Upload results to Blob storage 

    Parameters
    ----------
    credential : ClientSecretCredential,
    resources: list
    tests: dict

    Returns
    -------
    dict

    Raises
    ------
    HttpResponseError
        If starting the test run  fails
    TimeoutError
        If waiting for the results file timed out with error
    """
    test_runs = {}
    for resource in resources:

        runClient = LoadTestRunClient(
            credential=credential, endpoint=resource['data_plane_uri'])
        test_run_id = "test-run-" + str(int(time.time()))

        try:
            testRunPoller = runClient.begin_test_run(
                test_run_id,
                {
                    "testId": tests[resource['location']],
                    "displayName": "Load Test Run - "+resource['location']+" - "+str(int(time.time())),
                }
            )
            test_runs[resource['location']] = {
                "testRunPoller": testRunPoller, "test_run_id": test_run_id}

        except HttpResponseError as e:
            print("Failed with error: {}".format(e.response.json()))
            exit(1)
    print("Test runs")
    print(test_runs)
    time.sleep(500)

    for resource in resources:
        testRunPoller = test_runs[resource['location']]['testRunPoller']
        runClient = LoadTestRunClient(
            credential=credential, endpoint=resource['data_plane_uri'])
        try:
            while not testRunPoller.done():
                test_run_result = testRunPoller.polling_method().resource()
                print(
                    "Status response at {} : {}".format(
                        str(int(time.time())), test_run_result.get(
                            "status", None)
                    )
                )
                time.sleep(10)

            test_run_result = testRunPoller.result()
            print(
                "Final status response at {} : {}".format(
                    str(int(time.time())), test_run_result.get("status", None)
                )
            )

            # Wait for results file to be available
            timeout = time.time() + int(
                config["DEFAULT"]["results_timeout"] or 300
            )  # default 5 minutes
            while True:
                if time.time() > timeout:
                    raise TimeoutError(
                        "Timeout waiting for results file to be available")
                test_run_result = runClient.get_test_run(
                    test_runs[resource['location']]['test_run_id'])
                if (
                    test_run_result["testArtifacts"]["outputArtifacts"]
                    .get("resultFileInfo", {})
                    .get("url")
                    is not None
                ):
                    break
                time.sleep(10)

        except TimeoutError as e:
            print("Waiting for results timed out with error: {}".format(
                e.response.json()))
            exit(1)
        print("Test run result")
        print(test_run_result)
        results = extract_and_update_results(
            test_run_result, test_runs[resource['location']]['test_run_id'], resource['location'])
        blob = BlobClient.from_connection_string(
            conn_str=config["DEFAULT"]["connection_string"],
            container_name=config["DEFAULT"]["container_name"],
            blob_name=results["csv_file_name"],
        )
        with open(results["csv_file_path"] / results["csv_file_name"], "rb") as data:
            blob.upload_blob(data)


def main():

    # Authentication using service principal
    credential = ClientSecretCredential(
        client_id=config["DEFAULT"]["client_id"],
        client_secret=config["DEFAULT"]["client_secret"],
        grant_type="client_credentials",
        resource=config["DEFAULT"]["token_resource"],
        tenant_id=config["DEFAULT"]["tenant"],
    )

    regions = config["DEFAULT"]["regions"].split(",")

    # Getting Azure Load Testing management client for managing Azure Load Testing resources
    mgmtClient = LoadTestMgmtClient(
        credential=credential, subscription_id=config["DEFAULT"]["subscription_id"])

    # Creating Azure Load Testing resources in the regions specified in the config file
    resources = create_resources(mgmtClient, regions)

    # Creating tests in the resources created above, using the test srtifacts specified in the config file
    tests = create_tests(credential, resources)
    # Waiting for test creation to complete
    time.sleep(120)

    # Run the tests created above and export results to the storage account specified in the config file
    run_tests(credential, resources, tests)


if __name__ == "__main__":
    main()
