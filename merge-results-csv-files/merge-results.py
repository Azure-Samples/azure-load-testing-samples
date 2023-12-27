import configparser
import io
from zipfile import ZipFile
from pathlib import Path

import pandas as pd
import requests
from azure.developer.loadtesting import (
    LoadTestRunClient,
)
from azure.identity import ClientSecretCredential
from azure.mgmt.loadtesting import LoadTestMgmtClient

config = configparser.ConfigParser()
config.read("config.ini")

def extract_and_update_results(test_run_id, test_run_response):
    """
    Downloads the results Zip file from the specified test run, extracts the Zip file,
    adds a column to each CSV file in the Zip file with the engine number, and saves
    the updated CSV file.

    Parameters
    ----------
    test_run_id : str
        The ID of the test run.
    test_run_response : dict
        The response object containing the test run information.

    Raises
    ------
    TypeError
        If the test_run_response is not a dictionary.
    """
    if not isinstance(test_run_response, dict):
        raise TypeError("test_run_response must be a dictionary")

    results_zip_url = test_run_response['testArtifacts']['outputArtifacts']['resultFileInfo']['url']
    engine_count = test_run_response['loadTestConfiguration']['engineInstances']

    csv_file_path = Path("./testRunResults")

    ZipFile(io.BytesIO(requests.get(results_zip_url).content)).extractall(csv_file_path)

    consolidated_results_df = pd.DataFrame()

    for engine_index in range(1, engine_count+1):
        results_df = pd.read_csv(csv_file_path/f"engine{str(engine_index)}_results.csv")
        results_df["engine_number"] = engine_index
        consolidated_results_df = pd.concat([consolidated_results_df, results_df], ignore_index=True)  # Concatenate results_df to consolidated_results_df

    csv_file_name = f"csvTestResults_{test_run_id}_consolidated.csv"
    consolidated_results_df.to_csv(
        csv_file_path/csv_file_name,
        index=False,
        header=True,
    )

def main():
    """
    Main function to extract the results and consolidate the CSV file
    """
    credential = ClientSecretCredential(
        grant_type="client_credentials", **config["CREDENTIAL"]
    )
    
    # Getting Azure Load Testing management client for managing Azure Load Testing resources
    mgmt_client = LoadTestMgmtClient(
        credential=credential, subscription_id=config["DEFAULT"]["subscription_id"]
    )
    # Getting the data plane endpoint for the Azure Load Testing resource
    data_plane_uri = mgmt_client.load_tests.get(resource_group_name = config["DEFAULT"]["resource_group"], load_test_name = config["DEFAULT"]["loadtest_resource_name"]).data_plane_uri
    
    # Getting the runclient for the Azure Load Testing resource
    run_client = LoadTestRunClient(credential = credential,endpoint = data_plane_uri)

    # Get the test run results 
    test_run_response = run_client.get_test_run(config["DEFAULT"]["test_run_id"])

    # Extract the results and consolidate the CSV file
    extract_and_update_results(config["DEFAULT"]["test_run_id"], test_run_response)

if __name__ == "__main__":
    main()
