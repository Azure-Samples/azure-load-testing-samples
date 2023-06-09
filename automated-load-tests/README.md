---
page_type: sample
languages:
- Python
products:
- azure
- azure-load-testing
urlFragment: automated-load-tests
description: Automatically run and monitor load tests by using the Azure Load Testing library for Python
---

# Automated load tests using the Azure Load Testing library for Python

Using Azure Load Testing (ALT), customers can run load tests and get a unified dashboard of test statistics, client-side metrics, and server-side metrics so that the performance bottlenecks can be easily identified. While run tests and view the results dashboard, you might want to run the tests automatically on a schedule and monitor the results using a customized dashboard.  

This is a sample set up to run load tests automatically in Azure Load Testing and monitor the test results using a customized dashboard in a tool like PowerBI. 

Information on a sample scenario and instructions to use are available at https://techcommunity.microsoft.com/t5/apps-on-azure-blog/automatically-run-and-monitor-performance-tests-in-azure-load/ba-p/3827088

## Files in this sample 

1. `runTest.py` - Python script to run load tests, fetch load testing results and upload the CSV file to a blob storage
2. `Demo podcast test.jmx` - JMeter script to run a load test against the .NET podcast web application (https://github.com/Azure-Samples/azure-load-testing-samples/)
3. `Load Test Dashboard.pbit` - PowerBI template file with charts to visualize load test results

## Resources 

- Learn more about [Azure Load Testing](https://aka.ms/malt)
- [Azure Load Testing documentation](https://aka.ms/malt-docs)
