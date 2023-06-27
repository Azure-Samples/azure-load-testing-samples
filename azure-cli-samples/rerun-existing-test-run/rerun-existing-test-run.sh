# Rerun the most recent test run
subscription="<subscriptionId>" # add subscription here
resourceGroup="myRG"
location="East US"
loadTestResource="myLoadTestResource"
testId = "myLoadTest"

az account set -s $subscription # ...or use 'az login'
az configure --defaults group=$resourceGroup

newTestRunId="run_"`date +"%Y%m%d%_H%M%S"`
displayName="Run_"`date +"%Y/%m/%d_%H:%M:%S"`

# Get the most recent test run for a test
recentTestRunId=$(az load test-run list --load-test-resource $loadTestResource --test-id $testId --query "max_by([], &startDateTime).testRunId" -o tsv)

# Rerun the test run
az load test-run create --load-test-resource $loadTestResource --test-id $testId --existing-test-run-id $recentTestRunId --test-run-id $newTestRunId --display-name $displayName --description "New Test run"

# Get test run client-side metrics
az load test-run metrics list --load-test-resource $loadTestResource --test-run-id $newTestRunId --metric-namespace LoadTestRunMetrics
