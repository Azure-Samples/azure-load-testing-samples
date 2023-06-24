---
page_type: sample
languages:
- bash
- azurecli
products:
- azure
- azure-load-testing
urlFragment: azure-load-testing-rerun-azure-cli
description: Rerun an existing test run from Azure CLI extension for Azure Load Testing
---

# Rerun an existing test run by using the Azure CLI extension for Azure Load Testing

This project demonstrates how to use an Azure CLI sample script to rerun an existing test run by using on Azure Load Testing.

In this sample script we perform the following operations:

1. Get the most recently run test run Id for a test
1. Rerun the test
1. Display the client side metrics for the test run

## Prerequisites

1. An existing Azure subscription. If you don't already have a Microsoft Azure subscription, you can create one for free [here](http://go.microsoft.com/fwlink/?LinkId=330212).
1. An existing resource group.
1. Azure CLI. You can install by following the steps mentioned [here](https://docs.microsoft.com/cli/azure/install-azure-cli).
1. An existing Azure Load Testing resource and a load test with existing test runs.

## Getting started

### Preparation

1. Open the source code in VS Code.

1. Update the `rerun-existing-test-run.sh` file and replace the text placeholders:

    | Placeholder | Description |
    | ----------- | ----------- |
    | `<subscriptionId>` | Azure subscription Id |
    | `<myRG>` | Resource group that contains the Azure Load Testing resource. |
    | `<myLoadTestResource>` | Name of the Azure Load Testing resource.  |
    | `<myLoadTest>` | Unique name for the load test, must contain only lower-case alphabetic, numeric, underscore or hyphen characters. |

### Run the sample

1. Open a bash session and run the following command.

	 ``` Bash
	 ./rerun-existing-test-run.sh
	 ```

1. Go to the [Azure portal](https://portal.azure.com).

1. Go to the Azure Load Testing resource to view the test results.

## Resources

- [Azure CLI for Azure Load Testing documentation](https://learn.microsoft.com/cli/azure/service-page/azure%20load%20testing)
- Learn more about [Azure Load Testing](https://aka.ms/malt)
- [Azure Load Testing documentation](https://aka.ms/malt-docs)
