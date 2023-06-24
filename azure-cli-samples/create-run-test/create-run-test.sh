# Create and run a load test and download results
# Variables
subscription="<subscriptionId>" # add subscription here
resourceGroup="<myRG>"
location="East US"
loadTestResource="<myLoadTestResource>"
testId = "<myLoadTest>"

az account set -s $subscription # ...or use 'az login'

az configure --defaults group=$resourceGroup

# Create a resource
az load create --name $loadTestResource --location $location

# Create a test
testPlan="sample.jmx"
az load test create --load-test-resource  $loadTestResource --test-id $testId  --display-name "My CLI Load Test" --description "Created using Az CLI" --test-plan $testPlan --engine-instances 1


# Add an app component
az load test app-component add --load-test-resource $loadTestResource \
                                --test-id $testId \
                                --app-component-id "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/samplerg/providers/Microsoft.Web/sites/appcomponentresource" \
				--app-component-type "Microsoft.Web/sites" \
				--app-component-name "appcomponentresource"

# Create a server metric for the app component
az load test server-metrics add --load-test-resource $loadTestResource \
                                --test-id $testId \
                                --metric-id "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/samplerg/providers/microsoft.insights/components/appcomponentresource/providers/microsoft.insights/metricdefinitions/requests/duration"
				--metric-name "Http4xx" \
				--metric-namespace "Microsoft.Web/sites" \
				--app-component-id "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/samplerg/providers/Microsoft.Web/sites/appcomponentresource" \
				--app-component-type "Microsoft.Web/sites" \
				--aggregation "Average"


# Run the test
testRunId="run_"`date +"%Y%m%d%_H%M%S"`
displayName="Run"`date +"%Y/%m/%d_%H:%M:%S"`

az load test-run create --load-test-resource $loadTestResource --test-id $testId --test-run-id $testRunId --display-name $displayName --description "Test run from CLI"

# Download results
az load test-run download-files --load-test-resource $loadTestResource --test-run-id $testRunId --path "testResults" --result