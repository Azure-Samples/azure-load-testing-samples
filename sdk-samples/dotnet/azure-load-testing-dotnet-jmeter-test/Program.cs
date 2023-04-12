using Azure;
using Azure.Core;
using Azure.Developer.LoadTesting;
using Azure.Identity;
using Azure.ResourceManager;
using Azure.ResourceManager.LoadTesting;
using Azure.ResourceManager.Resources;

const string resourceGroupName = "{my-load-test-resource-group}";
const string loadTestResourceName = "{my-load-test-resource}";
const string jmeterTestId = "my-jmeter-test-id";
const string jmxFilename = "sample.jmx";

// Create a default TokenCredential to authenticate with Azure
TokenCredential credential = new DefaultAzureCredential();

// Create or retrieve a resource group
ResourceGroupResource resourceGroup = await GetResourceGroup(credential, resourceGroupName);

// Create or retrieve an Azure Load Testing resource
LoadTestingResource resource = await GetLoadTestingResource(resourceGroup, loadTestResourceName);

// Get the data plane URI to manage and run load tests
Uri endpointUrl = new Uri("https://" + resource.Data.DataPlaneUri);

// Get the load test administration client
LoadTestAdministrationClient loadTestAdministrationClient = GetLoadTestAdminClient(credential, endpointUrl);

// Create a JMeter test
GetJMeterTest(loadTestAdministrationClient, jmeterTestId, jmxFilename);

// Add app components to monitor server-side metrics
CreateOrUpdateAppComponents(loadTestAdministrationClient, jmeterTestId);

// Run the load test
RunLoadTest(credential, endpointUrl, jmeterTestId);

/// <summary>
/// Creates or updates a resource group.
/// </summary>
/// <param name="credential">The credential to use for authentication.</param>
/// <param name="resourceGroupName">The name of the resource group to create or update.</param>
/// <returns>The created or updated resource group.</returns>
static async Task<ResourceGroupResource> GetResourceGroup(TokenCredential credential, string resourceGroupName)
{
	Console.WriteLine("--> Started resource group create/update");

	ArmClient armClient = new ArmClient(credential);
	SubscriptionResource subscription = await armClient.GetDefaultSubscriptionAsync();
	ResourceGroupCollection rgCollection = subscription.GetResourceGroups();
	AzureLocation location = AzureLocation.EastUS;
	ArmOperation<ResourceGroupResource> resourceGroupLro = await rgCollection.CreateOrUpdateAsync(WaitUntil.Completed, resourceGroupName, new ResourceGroupData(location));
	ResourceGroupResource resourceGroup = resourceGroupLro.Value;

	Console.WriteLine("--> Completed resource group create/update");

	return resourceGroup;
}

/// <summary>
/// Creates or updates an Azure Load Testing resource.
/// </summary>
/// <param name="resourceGroup">The resource group to create the Azure Load Testing resource in.</param>
/// <param name="loadTestResourceName">The name of the Azure Load Testing resource to create or update.</param>
/// <returns>The created or updated Azure Load Testing resource.</returns>
static async Task<LoadTestingResource> GetLoadTestingResource(ResourceGroupResource resourceGroup, string loadTestResourceName)
{
	Console.WriteLine("--> Started Azure Load Testing resource create/update");
	LoadTestingResourceCollection loadTestingCollection = resourceGroup.GetLoadTestingResources();
	LoadTestingResourceData inputPayload = new LoadTestingResourceData(AzureLocation.EastUS);
	ArmOperation<LoadTestingResource> loadTestingLro = await loadTestingCollection.CreateOrUpdateAsync(WaitUntil.Completed, loadTestResourceName, inputPayload);
	LoadTestingResource resource = loadTestingLro.Value;

	Console.WriteLine("--> Completed Azure Load Testing resource create/update");
	return resource;
}

/// <summary>
/// Get load test administration client for the Azure Load Testing resource.
/// </summary>
/// <param name="credential">The credential to use for authentication.</param>
/// <param name="endpointUrl">The data plane URI of the Azure Load Testing resource.</param>
/// <returns>The load test administration client for the Azure Load Testing resource.</returns>
static LoadTestAdministrationClient GetLoadTestAdminClient(TokenCredential credential, Uri endpointUrl) {
	return new LoadTestAdministrationClient(endpointUrl, credential);
}

/// <summary>
/// Creates a JMeter test configuration.
/// The configuration contains a test fail criteria based on error percentage.
/// </summary>
/// <returns>A JSON object that can be used to create a JMeter test.</returns>
static object GetJMeterTestConfiguration()
{
	// all data needs to be passed while creating a loadtest
	var data = new
	{
		description = "This is created using SDK",
		displayName = "SDK's JMeter test",
		loadTestConfiguration = new
		{
			engineInstances = 1,
			splitAllCSVs = false,
			quickStartTest = false,
		},
		passFailCriteria = new
		{
			passFailMetrics = new
			{
				condition1 = new
				{
					clientmetric = "error",
					aggregate = "percentage",
					condition = ">",
					value = 50
				}
			},
		}
	};

	return data;
}

/// <summary>
/// Creates a JMeter test. If the test already exists, a new test run is added to the test.
/// </summary>
/// <param name="loadTestAdministrationClient">The load test administration client.</param>
/// <param name="testId">The ID of the quick test to create or reuse.</param>
/// <param name="jmxFilename">File name of the JMeter test script.</param>
static void GetJMeterTest(LoadTestAdministrationClient loadTestAdministrationClient, string testId, string jmxFilename)
{
	try
	{
		string jmxContent = File.ReadAllText(jmxFilename);

		Response response = loadTestAdministrationClient.CreateOrUpdateTest(testId, RequestContent.Create(GetJMeterTestConfiguration()));

		// poller object
		FileUploadResultOperation operation = loadTestAdministrationClient.UploadTestFile(WaitUntil.Started, testId, jmxFilename, RequestContent.Create(jmxContent));

		// get the intial reponse for uploading file
		Response initialResponse = operation.GetRawResponse();
		Console.WriteLine(initialResponse.Content.ToString());

		// run lro to check the validation of file uploaded
		operation.WaitForCompletion();

		// printing final response
		Response validatedFileResponse = operation.GetRawResponse();
		Console.WriteLine(validatedFileResponse.Content.ToString());
	}
	catch (Exception ex)
	{
		Console.WriteLine(ex.Message);
	}
}

/// <summary>
/// Run a load test.
/// </summary>
/// <param name="credential">The credential to use for authentication.</param>
/// <param name="endpointUrl">The data plane URI of the Azure Load Testing resource.</param>
/// <param name="testId">The ID of the test to run.</param>
static void RunLoadTest(TokenCredential credential, Uri endpointUrl, string testId)
{
	Console.WriteLine("--> Started test run creation");
	LoadTestRunClient loadTestRunClient = new LoadTestRunClient(endpointUrl, credential);

	string testRunId = "run-" + DateTime.Now.Ticks.ToString();

	var runData = new
	{
		testid = testId,
		displayName = "Test run " + DateTime.Now.ToString()
	};

	try
	{
		TestRunResultOperation operation = loadTestRunClient.BeginTestRun(
				WaitUntil.Started, testRunId, RequestContent.Create(runData));

		// get inital response
		Response initialResponse = operation.GetRawResponse();
		Console.WriteLine(initialResponse.Content.ToString());

		// waiting for testrun to get completed
		operation.WaitForCompletion();

		// final reponse
		Response finalResponse = operation.GetRawResponse();
		Console.WriteLine(finalResponse.Content.ToString());

		Console.WriteLine("--> Completed test run");
	}
	catch (Exception ex)
	{
		Console.WriteLine(ex.Message);
	}
}

/// <summary>
/// Creates or updates the app components for a test. Default server-side metrics are added to the load testing dashboard.
/// </summary>
/// <param name="loadTestAdministrationClient">The load test administration client.</param>
/// <param name="testId">The ID of the test to create or update the app components for.</param>
static void CreateOrUpdateAppComponents(LoadTestAdministrationClient loadTestAdministrationClient, string testId)
{
	// TODO: add or remove Azure resources to monitor during the load test	
	// TODO: replace placeholders to your Azure subscription and Azure resource

	string planResourceId = "/subscriptions/{my-subscription-id}/resourceGroups/ntloadtestweb-rg/providers/Microsoft.Web/serverfarms/{my-appservice-plan}";

	try
	{
		Console.WriteLine("--> Started add app components");

		Response response = loadTestAdministrationClient.CreateOrUpdateAppComponents(testId, RequestContent.Create(
				new Dictionary<string, Dictionary<string, Dictionary<string, string>>>
				{
				{ "components",  new Dictionary<string, Dictionary<string, string>>
					{
						{ planResourceId, new Dictionary<string, string>
							{
								{ "resourceId", planResourceId },
								{ "resourceName", "{my-appservice-plan}" },
								{ "resourceType", "Microsoft.Web/serverfarms" },
								{ "kind", "app" }
							}
						},
					}
				}
				}
			));

		Console.WriteLine(response.Content.ToString());

		Console.WriteLine("--> Completed add app components");
	}
	catch (Exception ex)
	{
		Console.WriteLine(ex.Message);
	}
}
