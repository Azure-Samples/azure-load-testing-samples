# Performance Starter Kit for JMeter and Azure Load Testing
The performance starter kit for JMeter is designed to streamline the performance testing process using Azure Load Testing. Using this kit, you can:

1. Prerequisites Installation: The kit installs the latest version of Java as a prerequisite for using JMeter.
2. JMeter Setup: It handles the setup of JMeter, ensuring that users are ready to use it immediately.
3. JMeter Plugins Installation: The kit installs essential JMeter plugins, which are crucial for creating real-world performance test scripts.
4. Standard JMeter Template Script: It generates a standard JMeter template script, helping performance testers create scripts faster.
5. Auto Suite Generation: It assists in the automatic generation of test suites (.jmx files).
6. Ensure Compatibility with ALT: The kit converts your JMeter test scripts to be compatible for use with Azure Load Testing.
7. Azure Load Test Setup and Execution: It helps you create the Azure Load Testing resource, sets up your JMeter test, and runs the test using the managed service.
8. Generic Report Generation: The kit includes a facility for generating generic JMeter reports from result JTL files.
9. JMeter Test Best Practices: The kit provides guidelines for best practices in JMeter testing.

# How to Use the Kit
1. Clone the repository to your local machine.
2. Install Azure CLI If you haven't already. You can find the installation instructions [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
3. Update the `config.json` file with your Azure credentials(Tenant,subscription,Resource Group)and other necessary configurations(duration,secret,certificate,env variables if any) for running using ALT.
4. Enable starterkit setup if you want to install the prerequisites and setup JMeter. You can do this by setting the `enable_starterkit_setup` variable to `true` in the `config.json` file.
5. To generate the suite from APIM or Swagger you need to suitegenerationfromswagger or suitegenerationfromapimconfig=true and provide the swagger or apim file complete path in the config.json file.
Sample files are available in the [config_input_files](../performance-starterkit-jmeter/config_input_files) folder 
6. To enable html report generation set the reportgeneration variable to `true` in the `config.json` file and provide the path to the jtl file in the config.json file.

## Resources

- Learn more about [Azure Load Testing](https://aka.ms/malt)
- [Azure Load Testing documentation](https://aka.ms/malt-docs)