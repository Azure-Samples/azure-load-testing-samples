import io
import zipfile
from pathlib import Path
import pandas as pd
import requests
import configparser
import time

from azure.identity import ClientSecretCredential
from azure.mgmt.loadtesting import LoadTestMgmtClient
from azure.developer.loadtesting import LoadTestRunClient
from azure.storage.blob import BlobClient
from azure.core.exceptions import HttpResponseError

test_run_id = "test-run-"+str(int(time.time()))

def extract_and_update_results(test_run_response):
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
    engine_index = 1 # This sample test run uses only one engine. In case of multiple engines, iterate over the result CSV files from each engine

    zipfile.ZipFile(io.BytesIO(requests.get(results_zip_url).content)).extractall(csv_file_path)

    results_df = pd.read_csv(csv_file_path/f"engine{str(engine_index)}_results.csv")
    results_df["testRunName"] = test_run_response["displayName"]

    csv_file_name = f"csvTestResults_{test_run_id}_testengine{str(engine_index)}.csv"
    results_df.to_csv(
        csv_file_path/csv_file_name,
        index=False,
        header=True,
    )
    return {"csv_file_path":csv_file_path, "csv_file_name":csv_file_name}

def main():

    config = configparser.ConfigParser()  
    config.read(r".\configFile.ini")

    credential = ClientSecretCredential(
        client_id = config["DEFAULT"]["client_id"],
        client_secret = config["DEFAULT"]["client_secret"],
        grant_type = "client_credentials",
        resource = config["DEFAULT"]["token_resource"],
        tenant_id = config["DEFAULT"]["tenant"],
    )

    mgmtClient = LoadTestMgmtClient(credential = credential, subscription_id = config["DEFAULT"]["subscription_id"])

    data_plane_uri = mgmtClient.load_tests.get(resource_group_name = config["DEFAULT"]["resource_group"], load_test_name = config["DEFAULT"]["loadtest_resource_name"]).data_plane_uri

    runClient = LoadTestRunClient(credential = credential,endpoint = data_plane_uri)

    try:
        testRunPoller = runClient.begin_test_run(
        test_run_id,
        {
            "testId": config["DEFAULT"]["test_id"],
            "displayName": "Load Test Run - "+str(int(time.time())),
         }
    )

    #waiting for test run status to be completed with timeout = 1800 seconds.
        test_run_result = testRunPoller.result(1800)
    except HttpResponseError as e:
        print("Failed with error: {}".format(e.response.json()))
   
    results = extract_and_update_results(test_run_result)
    blob = BlobClient.from_connection_string(conn_str = config["DEFAULT"]["connection_string"], container_name = config["DEFAULT"]["container_name"], blob_name = results['csv_file_name'])
    with open(results['csv_file_path']/results['csv_file_name'], "rb") as data:
         blob.upload_blob(data)

if __name__ == "__main__":
    main()
