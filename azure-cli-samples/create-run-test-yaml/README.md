---
page_type: sample
languages:
- bash
- azurecli
products:
- azure
- azure-load-testing
urlFragment: azure-load-testing-create-with-yaml-azure-cli
description: Create and run load test with load test with load testing YAML config file from Azure CLI extension for Azure Load Testing
---

# Create and run a load test with YAML configuration by using the Azure CLI

This project demonstrates how to use an Azure CLI sample script to create and run a load test with [load testing YAML config file](https://learn.microsoft.com/azure/load-testing/reference-test-config-yaml) on Azure Load Testing.

In this sample script we perform the following operations:

1. Create an Azure load testing resource
1. Create a load test with load testing YAML config file
1. Add app components to the test for monitoring
1. Add server metrics for the app component
1. Run the test by creating a test run
1. Download result files for the test run

## Prerequisites

1. An existing Azure subscription. If you don't already have a Microsoft Azure subscription, you can create one for free [here](http://go.microsoft.com/fwlink/?LinkId=330212).
1. An existing resource group.
1. Azure CLI. You can install by following the steps mentioned [here](https://docs.microsoft.com/cli/azure/install-azure-cli).

## Getting started

### Preparation

1. Open the source code in VS Code.

1. Update the `create-run-test-yaml.sh` file and replace the text placeholders:

    | Placeholder | Description |
    | ----------- | ----------- |
    | `<subscriptionId>` | Azure subscription ID |
    | `<myRG>` | Resource group that contains the Azure load testing resource. |
    | `<myLoadTestResource>` | Name of the Azure load testing resource.  |
    | `<myLoadTest>` | Unique name for the load test, must contain only lower-case alphabetic, numeric, underscore or hyphen characters. |

1. Update the absolute path for the YAML file in `loadTestConfig`.

1. Update the app component(s) and server metric(s) for the target application you are testing. You can get these details using the `az resource show`command. [Learn more](https://learn.microsoft.com/cli/azure/resource?#az-resource-show).

1. Update the `sample.jmx` file and replace the text placeholders:

    | Placeholder | Description |
    | ----------- | ----------- |
    | `{my-app-endpoint}` | URL of the application endpoint to test. |

### Run the sample

1. Open a bash session and run the following command.

	 ``` Bash
	 ./create-run-test-yaml.sh
	 ```

1. Go to the [Azure portal](https://portal.azure.com).

1. Go to the Azure load testing resource to view the test results.

## Resources

- [Azure CLI for Azure Load Testing documentation](https://learn.microsoft.com/cli/azure/service-page/azure%20load%20testing)
- Learn more about [Azure Load Testing](https://aka.ms/malt)
- [Azure Load Testing documentation](https://aka.ms/malt-docs)
