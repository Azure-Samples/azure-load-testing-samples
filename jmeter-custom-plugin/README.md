---
page_type: sample
products:
- azure-load-testing
urlFragment: azure-load-testing-jmeter-custom-plugin
description: Create and Integrate Custom Plugin for JMeter in Azure Load Testing
---

# Create Custom plugin and Integrate in Jmeter for Azure Load Testing

As .Jar(Java Archive) can be easily integrated to Jmeter. Custom Plugin can be created in Java project and all functions can be called straightly using JSR223Sample or Beanshell sampler.
In this sample we will talking about steps for creating custom plugin

## Prerequisites

- An Azure Load Testing resource. An Azure Load Testing resource. To create a Load Testing resource, see [Create and run a load test](https://learn.microsoft.com/azure/load-testing/quickstart-create-and-run-load-test#create-an-azure-load-testing-resource).
- Creating Custom Plugin and integrating it with JMeter [Create and Integrate custom plugin](https://techcommunity.microsoft.com/t5/apps-on-azure-blog/custom-plugin-creation-and-integration-with-jmeter-and-azure/ba-p/3745773).

## Run this sample

1. Download the Sample Java Maven project - **codepackage**
2. Using Maven create a JAR using the command 
mvn clean compile assembly:single
Note: Execute this command on the location having .pom file present.
3. Link the new JAR in the JMeter Suite - Click on browse and import jar.
Note Use the name of the JAR file instead of using the complete path of the JAR file 
for example. in our case we have name as sampleexample-1.0-jar-with-dependencies.jar
4. Create a BeanShell or JSR223 Sampler in your JMeter Suite and import the package after this create an object of class and call the functions.
5. Upload the .jmx file and .jar file in Azure Load Testing or in ADO pipeline and perform the execution

