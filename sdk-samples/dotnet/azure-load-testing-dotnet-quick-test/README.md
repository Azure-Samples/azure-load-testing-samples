---
page_type: sample
languages:
- csharp
products:
- azure
- azure-load-testing
urlFragment: azure-load-testing-dotnet-quick-test
description: Create an Azure Load Testing quick test by using the Azure Load Testing library for .NET
---

# Create a quick test by using the Azure Load Testing library for .NET

This sample demonstrates how to create and run an Azure Load Testing quick test with the [Azure Load Testing .NET language libraries](https://learn.microsoft.com/dotnet/api/overview/azure/load-testing?view=azure-dotnet).

The sample performs the following steps:

1. Get an Azure authentication token
1. Create or retrieve a resource group
1. Create or retrieve an Azure load testing resource
1. Create a quick test for a specific URL, and define test fail criteria by using the load test administration client
1. Add app components to the test for monitoring server-side metrics
1. Run the quick test

## Getting started

### Preparation

1. Open the source code in VS Code.

1. Update the `Program.cs` file and replace the text placeholders:

    | Placeholder | Description |
    | ----------- | ----------- |
    | `{my-load-test-resource-group}` | Resource group that contains the Azure Load Testing resource. |
    | `{my-load-test-resource}` | Name of the Azure Load Testing resource. |
    | `{my-app-endpoint}` | URL of the application endpoint to test (only for quick test). |

1. Add or update the test fail criteria in `GetQuickTestConfiguration()`.

1. Add or update the app components to monitor in `CreateOrUpdateAppComponents()`.

### Run the sample

1. Open a command prompt and go to the sample folder.

1. Enter the following command to run the load test:

    ```dotnetcli
    dotnet run
    ```

1. Go to the [Azure portal](https://portal.azure.com).

1. Go to the Azure load testing resource to view the test results.

## Resources

- [Azure Load Testing documentation](https://learn.microsoft.com/azure/load-testing)
- [Azure Load Testing .NET language libraries](https://learn.microsoft.com/dotnet/api/overview/azure/load-testing?view=azure-dotnet)
- Get started by [creating a URL-based load test](https://learn.microsoft.com/azure/load-testing/quickstart-create-and-run-load-test)
- Get started by [creating a load test by using an existing JMeter script](https://learn.microsoft.com/azure/load-testing/how-to-create-and-run-load-test-with-jmeter-script)
