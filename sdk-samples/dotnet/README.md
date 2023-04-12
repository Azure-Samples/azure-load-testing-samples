# Manage load tests using the Azure Load Testing .NET language libraries

This folder contains sample code for managing load tests with the [Azure Load Testing .NET language libraries](https://learn.microsoft.com/dotnet/api/overview/azure/load-testing?view=azure-dotnet).

## Code samples

1. [Create a quick test by using .NET](./azure-load-testing-dotnet-quick-test/)
1. [Create a load test by using a JMeter test script](./azure-load-testing-dotnet-jmeter-test/)

## Getting started

### Preparation

1. Open the source code in VS Code.

1. Replace the text placeholders in the `Program.cs` file:

    | Placeholder | Description |
    | ----------- | ----------- |
    | `{my-load-test-resource-group}` | Resource group that contains the Azure Load Testing resource. |
    | `{my-load-test-resource}` | Name of the Azure Load Testing resource. |
    | `{my-app-endpoint}` | Url of the application endpoint to test (only for quick test). |

1. Add or update the test fail criteria in `GetQuickTestConfiguration()`.

1. Add or update the app components to monitor in `CreateOrUpdateAppComponents()`.

1. (JMeter-based test) Replace the `{my-app-endpoint}` placeholder text in `sample.jmx` with your application endpoint.

### Run the load test

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
