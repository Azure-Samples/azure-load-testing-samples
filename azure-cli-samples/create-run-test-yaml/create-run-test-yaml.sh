# Create and run a load test and download results

subscription="<subscriptionId>" # add subscription here
resourceGroup="<myRG>"
location="East US"
loadTestResource="<myLoadTestResource>"
testId = "<myLoadTest>"

az account set -s $subscription # ...or use 'az login'
az configure --defaults group=$resourceGroup

# Create a resource
az load create --name $loadTestResource --location $location

# Create a test with Load Test config YAML file
loadTestConfig="config.yaml"
az load test create --load-test-resource  $loadTestResource --test-id $testId --load-test-config-file "config.yaml" --display-name $loadTestConfig --description "Created using Az CLI YAML" 

# Add an app component
az load test app-component add --load-test-resource  $loadTestResource --test-id $testId --app-component-id "/subscriptions/7c71b563-0dc0-4bc0-bcf6-06f8f0516c7a/resourceGroups/demo-podcast/providers/Microsoft.Web/sites/demo-podcastwebapp" --app-component-type "Microsoft.Web/sites" --app-component-name "demo-podcastwebapp"

# Create a server metric for the app component
az load test server-metric add --load-test-resource $loadTestResource --test-id $testId --metric-id "/subscriptions/7c71b563-0dc0-4bc0-bcf6-06f8f0516c7a/resourceGroups/demo-podcast/providers/Microsoft.Web/sites/demo-podcastwebapp/providers/microsoft.insights/metricdefinitions/Http4xx" --metric-name "Http4xx" --metric-namespace "Microsoft.Web/sites" --app-component-id "/subscriptions/7c71b563-0dc0-4bc0-bcf6-06f8f0516c7a/resourceGroups/demo-podcast/providers/Microsoft.Web/sites/demo-podcastwebapp" --app-component-type "Microsoft.Web/sites" --aggregation "Average"

# Run the test
testRunId="run_"`date +"%Y%m%d%_H%M%S"`
displayName="Run"`date +"%Y/%m/%d_%H:%M:%S"`

az load test-run create --load-test-resource $loadTestResource --test-id $testId --test-run-id $testRunId --display-name $displayName --description "Test run from CLI"

# Download results
az load test-run download-files --load-test-resource $loadTestResource --test-run-id $testRunId --path "Results" --result --force