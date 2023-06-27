---
page_type: sample
languages:
- bash
- azurecli
products:
- azure
- azure-load-testing
urlFragment: azure-load-testing-create-test-azure-cli
description: Create and run load test with load test from Azure CLI extension for Azure Load Testing
---

# Create and run a load test by using the Azure Load Testing Azure CLI extension

This project demonstrates how to use an Azure CLI sample script to create and run a load test on Azure Load Testing. You specify the load test configuration settings by using command-line parameters.

In this sample script we perform the following operations:

1. Create an Azure load testing resource
1. Create a load test
1. Run the test by creating a test run
1. View results for the test run

## Prerequisites

1. An existing Azure subscription. If you don't already have a Microsoft Azure subscription, you can create one for free [here](http://go.microsoft.com/fwlink/?LinkId=330212).
1. An existing resource group.
1. Azure CLI. You can install by following the steps mentioned [here](https://docs.microsoft.com/cli/azure/install-azure-cli).

## Getting started

### Preparation

1. Open the sample script in VS Code.

1. Update the `create-run-test.sh` file and replace the text placeholders:

    | Placeholder | Description |
    | ----------- | ----------- |
    | `<subscriptionId>` | Azure subscription Id |
    | `<myRG>` | Resource group that contains the Azure Load Testing resource. |
    | `<myLoadTestResource>` | Name of the Azure Load Testing resource.  |
    | `<myLoadTest>` | Unique name for the load test, must contain only lower-case alphabetic, numeric, underscore or hyphen characters. |

1. Update the path for the JMeter script in `testPlan`.

1. Update the app component(s) and server metric(s) for the target application you are testing.

1. Update the `sample.jmx` file and replace the text placeholders:

    | Placeholder | Description |
    | ----------- | ----------- |
    | `{my-app-endpoint}` | URL of the application endpoint to test. |

### Run the sample

1. Open a bash session and run the following command.

	 ``` Bash
	 ./create-run-test.sh
	 ```

1. Go to the [Azure portal](https://portal.azure.com).

1. Go to the Azure load testing resource to view the test results.

## Resources

- [Azure CLI for Azure Load Testing documentation](https://learn.microsoft.com/cli/azure/service-page/azure%20load%20testing)
- Learn more about [Azure Load Testing](https://aka.ms/malt)
- [Azure Load Testing documentation](https://aka.ms/malt-docs)
