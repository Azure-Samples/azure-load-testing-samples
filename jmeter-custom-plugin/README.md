---
page_type: sample
languages:
- xml
products:
- azure
- azure-load-testing
urlFragment: azure-load-testing-jmeter-read-csv
description: Read input data from a CSV file in Azure Load Testing
---

# Read input data from a CSV file in Azure Load Testing

In this sample, you read a list of urls from a CSV file and then call a *Dummy sampler* to simulate a web request for each URL. This sample contains a sample JMeter test script and a CSV file.

The test script contains 1 thread group, which runs infinitely. The *CSV Data Set Config* element is configured to stop the current thread when it reaches the end of the CSV file. As a result, the load test will iterate once over all records in the CSV file. Alternately, you can set the **Recycle on EOF** property on the *CSV Data Set Config* element to continue looping over the file until the end of the test.

The thread group contains a [Dummy sampler](https://jmeter-plugins.org/wiki/DummySampler/) that outputs the variables that correspond with the fields in the CSV file. You can update the test script to remove or disable the dummy sampler with an HTTP request.

## Prerequisites

- An Azure Load Testing resource. An Azure Load Testing resource. To create a Load Testing resource, see [Create and run a load test](https://learn.microsoft.com/azure/load-testing/quickstart-create-and-run-load-test#create-an-azure-load-testing-resource).
- Install the [Dummy sampler JMeter plugin](https://jmeter-plugins.org/wiki/DummySampler/) on your local JMeter installation.

## Run this sample

1. Follow these steps to [read data from a CSV file with Azure Load Testing](https://learn.microsoft.com/azure/load-testing/how-to-read-csv-data).

    - Upload the [JMeter test script](./read-from-csv.jmx) to your load test.
    - Upload the [CSV file with URLs](./websites.csv) to your load test.

1. Run the load test.


As .Jar(Java Archive) can be easily integrated to Jmeter. Custom Plugin can be created in Java project and all functions can be called straightly using JSR223Sample or Beanshell sampler.

Steps for Creating Custom Plugin
1. Download the Sample Java Maven project - azureloadtest_custompluginsample.zip
2. Using Maven create a JAR using the command 
mvn clean compile assembly:single
Note: Execute this command on the location having .pom file present.
3. Link the new JAR in the JMeter Suite - Click on browse and import jar.
Note Use the name of the JAR file instead of using the complete path of the JAR file 
for example. in our case we have name as sampleexample-1.0-jar-with-dependencies.jar
4. Create a BeanShell or JSR223 Sampler in your JMeter Suite and import the package after this create an object of class and call the functions.
5. Upload the .jmx file and .jar file in Azure Load Testing or in ADO pipeline and perform the execution

For more information Please refer - https://techcommunity.microsoft.com/t5/apps-on-azure-blog/custom-plugin-creation-and-integration-with-jmeter-and-azure/ba-p/3745773

