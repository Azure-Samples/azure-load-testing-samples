# Automated load tests

Using Azure Load Testing (ALT), customers can run load tests to simulate user traffic from the Azure region in which the load testing resource was created. However, in some scenarios there is a need for a multi-region load test that simulates user traffic from multiple Azure regions.

This is a sample set up to run load tests in parallel from multiple load testing resources located in different Azure regions and visualize the results using a customized dashboard in a tool like PowerBI. 

Information on a sample scenario and instructions to use are available at https://techcommunity.microsoft.com/t5/apps-on-azure-blog/multi-region-load-tests-using-azure-load-testing/ba-p/3873438

## Files in this sample 

1. `multi-region-tests.py` - Python script to set up and run a multi-region load test
2. `demo-podcast-test.jmx` - JMeter script to run a load test against the .NET podcast web application (https://github.com/Azure-Samples/azure-load-testing-samples/)
3. `load-test-dashboard.pbit` - PowerBI template file with charts to visualize load test results
4. `config.ini` - Configuration file to provide the inputs needed to run the Python script
5. `requirements.txt` - List of dependencies needed to run the Python script
6. `jmeter-plugins-functions-2.2.jar` - Supporting artifact for the JMeter script, JAR file for a custom plugin
7. `shows.csv` - Supporting artifact for the JMeter script, CSV file with test data

## Resources 

- Learn more about [Azure Load Testing](https://aka.ms/malt)
- [Azure Load Testing documentation](https://aka.ms/malt-docs)
