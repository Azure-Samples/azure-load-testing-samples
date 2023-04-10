# Azure Load Testing results integration

Azure Load Testing provides a unified dashboard of test statistics, client-side metrics, and server-side metrics that enable you to easily identify performance bottlenecks. You might want to use these load test results in a reporting tool of your choice.

This repository contains a sample set up to integrate and automatically visualize your Azure Load Testing results in a PowerBI dashboard.

You can find more information about this sample and instructions for how to use in the [following blog post](https://techcommunity.microsoft.com/t5/apps-on-azure-blog/automated-and-customized-dashboards-for-azure-load-testing/ba-p/3786891).

## Files in this sample

1. `exportResults.py` - Python script to fetch load testing results and upload the CSV file to a blob storage
2. `Demo podcast test.jmx` - JMeter script to run a load test against the [.NET podcast web application](https://github.com/Azure-Samples/azure-load-testing-samples/)
3. `Load Test Dashboard.pbit` - PowerBI template file with charts to visualize the load test results

## Resources

- Learn more about [Azure Load Testing](https://aka.ms/malt)
- [Azure Load Testing documentation](https://aka.ms/malt-docs)