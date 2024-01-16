---
page_type: sample
languages:
- Python, PowerShell
products:
- azure
- azure-load-testing
urlFragment: merge-results-csv-files
description: Automatically consolidate Azure Load Testing results into a single CSV file. 
---

# Automatically consolidate Azure Load Testing results into a single CSV file

When you use the download results option in Azure Load Testing, the service splits the results into one CSV file per engine. 

If you want to get one consolidated view of the test run results in a single file, you will have to go through a few manual steps to extract the zip file, open each CSV and copy the data into a single file. 

This sample shows two ways in which you can leverage automation for this scenario. 

1.	Download the results and consolidate into a single CSV file. You can use this option if you wish to automate the results download step as well. We will demonstrate this using a Python script. 

2.	Extract the downloaded Zip file and consolidate into a single CSV file. This is suitable if you have already downloaded the results file and you do not want to use any ALT APIs/SDKs for this automation. We will demonstrate this using a PowerShell script.
 

Information on a sample scenario and instructions to use are available at <link to be updated>

## Files in this sample 

1. `merge-results.py` - Python script to download test results and consolidate into a single file
2. `config.ini` - Config file to provide inputs needed to download test results using ALT SDK for Python
3. `merge-results.ps1` - PowerShell script to consolidate the test results into a single file

## Resources 

- Learn more about [Azure Load Testing](https://aka.ms/malt)
- [Azure Load Testing documentation](https://aka.ms/malt-docs)
