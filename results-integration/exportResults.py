import io
import zipfile
from pathlib import Path
import pandas as pd
import requests

from azure.identity import ClientSecretCredential
from azure.mgmt.loadtesting import LoadTestMgmtClient
from azure.developer.loadtesting import LoadTestRunClient
from azure.storage.blob import BlobClient

#Auth inputs
tenant = "<Your Tenant ID"
token_resource = "https://management.azure.com/"
client_id = "<Your service principal client ID>"
client_secret = input ("Service principal client secret: ")

# Load Test Inputs
subscription_id = "<Your Subscription ID>"

resource_group = "<Name of your resource group"
loadtest_resource_name = "<Name of your Azure Load Testing resource"

test_run_id = input ("Test Run ID: ")

# Storage account inputs
connection_string = input ("Storage account connection string: ")
container_name = "<Your Blob storage container name>"

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
    results_df["testRunName"] = test_run_response["description"]

    csv_file_name = f"csvTestResults_{test_run_id}_testengine{str(engine_index)}.csv"
    results_df.to_csv(
        csv_file_path/csv_file_name,
        index=False,
        header=True,
    )
    return {"csv_file_path":csv_file_path, "csv_file_name":csv_file_name}

def main():

    credential = ClientSecretCredential(
        client_id = client_id,
        client_secret = client_secret,
        grant_type = "client_credentials",
        resource = token_resource,
        tenant_id = tenant,
    )

    mgmtClient = LoadTestMgmtClient(credential = credential, subscription_id = subscription_id)

    data_plane_uri = mgmtClient.load_tests.get(resource_group_name = resource_group, load_test_name = loadtest_resource_name).data_plane_uri

    runClient = LoadTestRunClient(credential = credential,endpoint = data_plane_uri)
    test_run_response = runClient.get_test_run(test_run_id)

    results = extract_and_update_results(test_run_response)
    blob = BlobClient.from_connection_string(conn_str = connection_string, container_name = container_name, blob_name = results['csv_file_name'])
    with open(results['csv_file_path']/results['csv_file_name'], "rb") as data:
        blob.upload_blob(data) 

if __name__ == "__main__":
    main()
