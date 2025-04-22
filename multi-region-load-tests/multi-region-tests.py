import asyncio
import configparser
import io
import time
from typing import Awaitable, Dict, List
import uuid
import zipfile
from pathlib import Path

import pandas as pd
import requests
from azure.core.exceptions import HttpResponseError
from azure.developer.loadtesting.aio import (
    LoadTestAdministrationClient,
    LoadTestRunClient,
)
from azure.identity.aio import (
    ClientSecretCredential,
    ChainedTokenCredential,
    DefaultAzureCredential,
)
from azure.mgmt.loadtesting.aio import LoadTestMgmtClient
from azure.mgmt.loadtesting.models import LoadTestResource
from azure.storage.blob.aio import BlobClient
from azure.core.polling import AsyncLROPoller

region_display = {
    "australiaeast": "Australia East",
    "eastasia": "East Asia",
    "eastus": "East US",
    "uksouth": "UK South",
}

config = configparser.ConfigParser()
config.read("config.ini")


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

    results_zip_url = test_run_response["testArtifacts"]["outputArtifacts"][
        "resultFileInfo"
    ]["url"]

    csv_file_path = Path("./testRunResults")
    engine_index = 1  # This sample test run uses only one engine
    # In case of multiple engines, iterate over the result CSV files from each engine

    zipfile.ZipFile(io.BytesIO(requests.get(results_zip_url).content)).extractall(
        csv_file_path
    )

    results_df = pd.read_csv(csv_file_path / f"engine{str(engine_index)}_results.csv")
    results_df["testRunName"] = test_run_response["displayName"]
    results_df["Region"] = region_display[location]

    csv_file_name = f"csvTestResults_{test_run_id}_testengine{str(engine_index)}.csv"
    results_df.to_csv(
        csv_file_path / csv_file_name,
        index=False,
        header=True,
    )
    return {"csv_file_path": csv_file_path, "csv_file_name": csv_file_name}


async def create_resources(
    mgmt_client: LoadTestMgmtClient, regions: List[str]
) -> Awaitable[List[Dict[str, str]]]:
    """
    Create a resource in each region
    Get the resources details
    Append to a list

    Parameters
    ----------
    mgmt_client : LoadTestMgmtClient,
    regions: List[str]

    Returns
    -------
    Awaitable[List[Dict[str, str]]]

    Raises
    ------
    RuntimeError
        If resource creation fails
    """

    resource_group = config["DEFAULT"]["resource_group"]
    loadtest_resource_name = config["DEFAULT"]["loadtest_resource_name"]

    resources = []

    async def _create_resource(mgmt_client: LoadTestMgmtClient, region: str):
        try:
            poller: AsyncLROPoller[
                LoadTestResource
            ] = await mgmt_client.load_tests.begin_create_or_update(
                resource_group_name=resource_group,
                load_test_name=loadtest_resource_name + "-" + region,
                load_test_resource={"location": region},
                content_type="application/json",
            )

            await poller.wait()
            resource = await poller.result()

            if resource.provisioning_state == "Succeeded":
                print(f"Resource creation succeeded in region: {region}")
                return {
                    "name": resource.name,
                    "data_plane_uri": resource.data_plane_uri,
                    "location": resource.location,
                }
            else:
                print(f"Resource creation failed in region: {region}")
                return None

        except HttpResponseError as e:
            print("Service responded with error: {}".format(e.response.json()))
            return None

    tasks = [_create_resource(mgmt_client, region) for region in regions]
    resources = await asyncio.gather(*tasks)

    if any(resource is None for resource in resources):
        raise RuntimeError("Resource creation failed")

    return resources


async def create_tests(
    credential: ClientSecretCredential, resources: List[Dict[str, str]]
) -> Awaitable[Dict[str, str]]:
    """
    For each resources,
        Get LoadTestAdministrationClient
        Create a test
        Upload test artifacts
        Add test ID to a dictionary

    Parameters
    ----------
    credential : ClientSecretCredential,
    resources: List[Dict[str, str]]

    Returns
    -------
    Awaitable[Dict[str, str]]

    Raises
    ------
    RuntimeError
        If the test creation fails
    """
    file_names = [
        config["FILE"]["csv"],
        config["FILE"]["jar"],
        config["FILE"]["jmx"],
    ]

    async def _create_test(resource: Dict[str, str]):
        test_id = str(uuid.uuid4())
        admin_client = LoadTestAdministrationClient(
            endpoint=resource["data_plane_uri"], credential=credential
        )

        try:
            await admin_client.create_or_update_test(
                test_id,
                {
                    "description": "",
                    "displayName": "multi-region-load-test - " + resource["location"],
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
                                "value": 5,
                            },
                            "condition2": {
                                "clientmetric": "response_time_ms",
                                "aggregate": "avg",
                                "condition": ">",
                                "value": 1000,
                                "requestName": "Podcast page",
                            },
                        }
                    },
                    "environmentVariables": {
                        "webapp": "demo-podcastwebapp.azurewebsites.net"
                    },
                },
            )

            # uploading files to the test
            for file_name in file_names:
                with open(file_name, "rb") as file_handle:
                    poller = await admin_client.begin_upload_test_file(
                        test_id, file_name, file_handle
                    )
                    await poller.result()

            test_script_status = (await admin_client.get_test(test_id))[
                "inputArtifacts"
            ]["testScriptFileInfo"]["validationStatus"]

            if test_script_status == "VALIDATION_SUCCESS":
                print(f"Test creation succeeded in region: {resource['location']}")
                return (resource["location"], test_id)
            else:
                print(f"Test creation failed in region: {resource['location']}")
                return None

        except HttpResponseError as e:
            print("Service responded with error: {}".format(e.response.json()))
            return None

    tasks = [_create_test(resource) for resource in resources]
    tests = await asyncio.gather(*tasks)

    if any(test is None for test in tests):
        raise RuntimeError("Test creation failed")

    return dict(tests)


async def run_tests(
    credential: ClientSecretCredential,
    resources: Dict[str, str],
    tests: Dict[str, str],
):
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
    resources: Dict[str, str]
    tests: Dict[str, str]

    Raises
    ------
    TimeoutError
        If waiting for the results file timed out with error
    """

    async def _run_test(resource: Dict[str, str]):
        run_client = LoadTestRunClient(
            credential=credential, endpoint=resource["data_plane_uri"]
        )
        time_str = str(int(time.time()))
        test_run_id = f"test-run-{time_str}"

        try:
            poller = await run_client.begin_test_run(
                test_run_id,
                {
                    "testId": tests[resource["location"]],
                    "displayName": f"Load Test Run - {resource['location']} - {time_str}",
                },
            )
            test_run_result = poller.polling_method().resource()

            while not test_run_result.get("status", None) in [
                "DONE",
                "FAILED",
                "CANCELLED",
            ]:
                test_run_result = await run_client.get_test_run(test_run_id)
                print(
                    "Status response at {} in {}: {}".format(
                        str(int(time.time())),
                        resource["location"],
                        test_run_result.get("status", None),
                    )
                )
                await asyncio.sleep(10)

            test_run_result = await poller.result()
            print(
                "Final status response at {} in {}: {}".format(
                    str(int(time.time())),
                    resource["location"],
                    test_run_result.get("status", None),
                )
            )

            # Wait for results file to be available
            # default 5 minutes
            timeout = time.time() + int(config["DEFAULT"].get("results_timeout", 300))
            while True:
                if time.time() > timeout:
                    raise TimeoutError(
                        "Timeout waiting for results file to be available"
                    )
                test_run_result = await run_client.get_test_run(test_run_id)
                if (
                    test_run_result["testArtifacts"]["outputArtifacts"]
                    .get("resultFileInfo", {})
                    .get("url")
                    is not None
                ):
                    break
                await asyncio.sleep(10)

            # Upload results file
            print(f"Test run result: {test_run_result}")
            results = extract_and_update_results(
                test_run_result,
                test_run_id,
                resource["location"],
            )
            async with BlobClient.from_connection_string(
                conn_str=config["DEFAULT"]["connection_string"],
                container_name=config["DEFAULT"]["container_name"],
                blob_name=results["csv_file_name"],
                credential=credential,
            ) as blob:
                with open(
                    results["csv_file_path"] / results["csv_file_name"], "rb"
                ) as data:
                    await blob.upload_blob(data, overwrite=True)

        except HttpResponseError as e:
            print("Failed with error: {}".format(e.response.json()))
            None

    tasks = [_run_test(resource) for resource in resources]
    await asyncio.gather(*tasks)


async def main():
    # Authentication using service principal
    client_secret_cred = ClientSecretCredential(
        grant_type="client_credentials", **config["CREDENTIAL"]
    )

    credential = ChainedTokenCredential(client_secret_cred, DefaultAzureCredential())

    regions = config["DEFAULT"]["regions"].split(",")

    # Getting Azure Load Testing management client for managing Azure Load Testing resources
    mgmt_client = LoadTestMgmtClient(
        credential=credential, subscription_id=config["DEFAULT"]["subscription_id"]
    )

    # Creating Azure Load Testing resources in the regions specified in the config file
    resources = await create_resources(mgmt_client, regions)

    # Creating tests in the resources created above, using the test artifacts specified in the config file
    tests = await create_tests(credential, resources)

    # Run the tests created above and export results to the storage account specified in the config file
    await run_tests(credential, resources, tests)


if __name__ == "__main__":
    asyncio.run(main())
