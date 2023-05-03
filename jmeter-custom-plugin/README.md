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

