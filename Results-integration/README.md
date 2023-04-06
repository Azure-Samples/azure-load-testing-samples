# Results integration

Azure Load Testing (ALT) provides a unified dashboard of test statistics, client-side metrics, and server-side metrics so that the performance bottlenecks can be easily identified. While the out of the box dashboard is helpful in most scenarios, you might want the load test results to be available in a tool of your choice. 

This is a sample set up to integrate and automatically visualize Azure Load Testing results in a dashboarding tool like PowerBI. 

Information on a sample scenario and instructions to use are available at https://techcommunity.microsoft.com/t5/apps-on-azure-blog/automated-and-customized-dashboards-for-azure-load-testing/ba-p/3786891 

Files in this sample 

1. exportResults.py - Python script to fetch load testing results and upload the CSV file to a blob storage
2. Demo podcast test.jmx - JMeter script to run a load test against the .NET podcast web application (https://github.com/Azure-Samples/azure-load-testing-samples/)
3. Load Test Dashboard.pbit - PowerBI template file with charts to visualize load test results

Learn more about Azure Load Testing at https://aka.ms/malt
Refer to the documentation at https://aka.ms/malt-docs 