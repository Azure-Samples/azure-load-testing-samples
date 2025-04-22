# Sample JMeter test script for Azure Load Testing

This sample test script simulates a load test of five virtual users that simultaneously access a single web endpoint, and takes 2 minutes to complete.

Modify the test script to add your web endpoint URL:

1. Open the *SampleTest.jmx* file in a text editor.

1. Set the value of the `HTTPSampler.domain` node to the host name of your endpoint.

    For example, if you want to test the endpoint `https://www.contoso.com/app/products`, the host name is `www.contoso.com`.

    > [!WARNING]
    > Don't include `https` or `http` in the endpoint URL.

    ```xml
    <stringProp name="HTTPSampler.domain"></stringProp>
    ```

1. Set the value of the `HTTPSampler.path` node to the path of your endpoint.

    For example, the path for the URL `https://www.contoso.com/app/products` would be `/app/products`.

    ```xml
    <stringProp name="HTTPSampler.path"></stringProp>
    ```
