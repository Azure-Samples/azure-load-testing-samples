# Create and run a load test and download results
# Variables
subscription="subscriptionId" # add subscription here
resourceGroup="myRG"
location="East US"
loadTestResource="myLoadTestResource"
testId = "myLoadTest"

az account set -s $subscription # ...or use 'az login'

az configure --defaults group=$resourceGroup

# Create a resource
az load create --name $loadTestResource --location $location

# Create a test
testPlan="sample.jmx"
az load test create --load-test-resource  $loadTestResource --test-id $testId  --display-name "My CLI Load Test" --description "Created using Az CLI" --test-plan $testPlan --engine-instances 1

# Run the test
testRunId="run_"`date +"%Y%m%d%_H%M%S"`
displayName="Run"`date +"%Y/%m/%d_%H:%M:%S"`

az load test-run create --load-test-resource $loadTestResource --test-id $testId --test-run-id $testRunId --display-name $displayName --description "Test run from CLI"

# Get test run client-side metrics
az load test-run metrics list --load-test-resource $loadTestResource --test-run-id $testRunId --metric-namespace LoadTestRunMetrics