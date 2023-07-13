# Automated load tests

Using Azure Load Testing (ALT), customers can run load tests to simulate user traffic from the Azure region in which the load testing resource was created. However, in some scenarios there is a need for a multi-region load test that simulates user traffic from multiple Azure regions.

This is a sample set up to run load tests in parallel from multiple load testing resources located in different Azure regions and visualize the results using a customized dashboard in a tool like PowerBI. 

Information on a sample scenario and instructions to use are available at <Blogpost link to be included>

## Files in this sample 

1. `multi-region-tests.py` - Python script to set up and run a multi-region load test
2. `demo-podcast-test.jmx` - JMeter script to run a load test against the .NET podcast web application (https://github.com/Azure-Samples/azure-load-testing-samples/)
3. `load-test-dashboard.pbit` - PowerBI template file with charts to visualize load test results

## Resources 

- Learn more about [Azure Load Testing](https://aka.ms/malt)
- [Azure Load Testing documentation](https://aka.ms/malt-docs)