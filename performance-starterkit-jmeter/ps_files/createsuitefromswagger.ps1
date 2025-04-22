Write-Output "`n`n**** JMeter suite creation with Swagger - True ****"
Write-Output "              Creating JMeter Suite from Swagger               "
# Start-Sleep -Seconds 2

$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
$dir = Split-Path -Path $dir -Parent

if ($ENV:OS -match "Windows") {
    # Write-Host "Windows"
    $dir = $dir+"\results\jmetersuitefromswagger.jmx"
}
else {
    # Write-Host "Linux"
    $dir = $dir+"/jmetersuitefromswagger.jmx"
}

$startingpart = @"
<?xml version="1.0" encoding="UTF-8"?>
<jmeterTestPlan version="1.2" properties="5.0" jmeter="5.5">
  <hashTree>
    <TestPlan guiclass="TestPlanGui" testclass="TestPlan" testname="Test Plan" enabled="true">
      <stringProp name="TestPlan.comments"></stringProp>
      <boolProp name="TestPlan.functional_mode">false</boolProp>
      <boolProp name="TestPlan.serialize_threadgroups">false</boolProp>
      <elementProp name="TestPlan.user_defined_variables" elementType="Arguments" guiclass="ArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
        <collectionProp name="Arguments.arguments"/>
      </elementProp>
      <stringProp name="TestPlan.user_define_classpath"></stringProp>
    </TestPlan>
"@

$endpart = @"
 <ResultCollector guiclass="ViewResultsFullVisualizer" testclass="ResultCollector" testname="View Results Tree" enabled="true">
        <boolProp name="ResultCollector.error_logging">false</boolProp>
        <objProp>
          <name>saveConfig</name>
          <value class="SampleSaveConfiguration">
            <time>true</time>
            <latency>true</latency>
            <timestamp>true</timestamp>
            <success>true</success>
            <label>true</label>
            <code>true</code>
            <message>true</message>
            <threadName>true</threadName>
            <dataType>true</dataType>
            <encoding>false</encoding>
            <assertions>true</assertions>
            <subresults>true</subresults>
            <responseData>false</responseData>
            <samplerData>false</samplerData>
            <xml>false</xml>
            <fieldNames>true</fieldNames>
            <responseHeaders>false</responseHeaders>
            <requestHeaders>false</requestHeaders>
            <responseDataOnError>false</responseDataOnError>
            <saveAssertionResultsFailureMessage>true</saveAssertionResultsFailureMessage>
            <assertionsResultsToSave>0</assertionsResultsToSave>
            <bytes>true</bytes>
            <sentBytes>true</sentBytes>
            <url>true</url>
            <threadCounts>true</threadCounts>
            <idleTime>true</idleTime>
            <connectTime>true</connectTime>
          </value>
        </objProp>
        <stringProp name="filename"></stringProp>
      </ResultCollector>
      <hashTree/>
    </hashTree>
  </hashTree>
</jmeterTestPlan>
"@

$userdefinedvariable = @"
    <hashTree>
      <Arguments guiclass="ArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
        <collectionProp name="Arguments.arguments">
          <elementProp name="key" elementType="Argument">
            <stringProp name="Argument.name">key</stringProp>
            <stringProp name="Argument.value">value</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="basepath" elementType="Argument">
            <stringProp name="Argument.name">basepath</stringProp>
            <stringProp name="Argument.value">httpsampler_basepath</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
        </collectionProp>
      </Arguments>
      <hashTree/>
"@

$threadgroup = 
@"
      <ThreadGroup guiclass="ThreadGroupGui" testclass="ThreadGroup" testname="Thread Group" enabled="true">
        <stringProp name="ThreadGroup.on_sample_error">continue</stringProp>
        <elementProp name="ThreadGroup.main_controller" elementType="LoopController" guiclass="LoopControlPanel" testclass="LoopController" testname="Loop Controller" enabled="true">
          <boolProp name="LoopController.continue_forever">false</boolProp>
          <stringProp name="LoopController.loops">1</stringProp>
        </elementProp>
        <stringProp name="ThreadGroup.num_threads">1</stringProp>
        <stringProp name="ThreadGroup.ramp_time">1</stringProp>
        <boolProp name="ThreadGroup.scheduler">false</boolProp>
        <stringProp name="ThreadGroup.duration"></stringProp>
        <stringProp name="ThreadGroup.delay"></stringProp>
        <boolProp name="ThreadGroup.same_user_on_next_iteration">true</boolProp>
      </ThreadGroup>
"@

$httpsampler = @"
<HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="httpsampler_summary" enabled="true">
          <stringProp name="HTTPSampler.domain">$'{basepath}</stringProp>
          <stringProp name="HTTPSampler.port"></stringProp>
          <stringProp name="HTTPSampler.protocol">httpsampler_schemes</stringProp>
          <stringProp name="HTTPSampler.contentEncoding"></stringProp>
          <stringProp name="HTTPSampler.path">httpsampler_path</stringProp>
          <stringProp name="HTTPSampler.method">httpsampler_method</stringProp>
          <boolProp name="HTTPSampler.follow_redirects">true</boolProp>
          <boolProp name="HTTPSampler.auto_redirects">false</boolProp>
          <boolProp name="HTTPSampler.use_keepalive">true</boolProp>
          <boolProp name="HTTPSampler.DO_MULTIPART_POST">false</boolProp>
          <stringProp name="HTTPSampler.embedded_url_re"></stringProp>
          <stringProp name="HTTPSampler.connect_timeout"></stringProp>
          <stringProp name="HTTPSampler.response_timeout"></stringProp>
        </HTTPSamplerProxy>
        <hashTree>
          <HeaderManager guiclass="HeaderPanel" testclass="HeaderManager" testname="HTTP Header Manager" enabled="true">
            <collectionProp name="HeaderManager.headers">
              httpsampler_contenttype
            </collectionProp>
          </HeaderManager>
          <hashTree/>
          <ResponseAssertion guiclass="AssertionGui" testclass="ResponseAssertion" testname="Response Assertion" enabled="true">
            <collectionProp name="Asserion.test_strings">
              <stringProp name="49587">httpsampler_responsecode</stringProp>
            </collectionProp>
            <stringProp name="Assertion.custom_message"></stringProp>
            <stringProp name="Assertion.test_field">Assertion.response_code</stringProp>
            <boolProp name="Assertion.assume_success">false</boolProp>
            <intProp name="Assertion.test_type">2</intProp>
          </ResponseAssertion>
          <hashTree/>
        </hashTree>
"@

$contenttype = @"
        <elementProp name="Content-Type" elementType="Header">
            <stringProp name="Header.name">Content-Type</stringProp>
            <stringProp name="Header.value">application/json</stringProp>
        </elementProp>
"@

$jsonFilePath = $swaggerjsonpath
# $jsonFilePath = "C:\Users\shmarala\Documents\Learning\StarterKit\sampleswagger.json"
# $jsonFilePath = 

# Read the JSON file content
$jsonContent = Get-Content -Path $jsonFilePath -Raw

# Convert JSON content to a PowerShell object
$jsonObject = $jsonContent | ConvertFrom-Json
$startingpart = $startingpart -replace 'jmeter="5.5"', "jmeter=`"$jmeterversion`""
$finaljmx = $startingpart + $userdefinedvariable + $threadgroup +"<hashTree>"
$basepath = $jsonObject.basePath
$schemes = $jsonObject.schemes[0]
# $swaggersummary = $jsonObject.info.title # this will be name of the jmx file

# Iterate through the key-value pairs
foreach ($key in $jsonObject.PSObject.Properties.Name) {
    if($key -eq "paths")
    {   
        $value = $jsonObject.$key    # Path will be get fetched in Value.
        foreach ($path in $value.PSObject.Properties.Name) {
            $pathValue = $value.$path   # Method will be get fetched in Value
            $httpsampler_temp = $httpsampler
            foreach ($method in $pathValue.PSObject.Properties.Name) {
                $httpsamplersummary = $path #$pathValue.$method.summary
                $httpsamplerpath = $path
                $httpsamplermethod = $method.ToUpper()
                $httpssamplerresponsecode = ""
                switch ($httpsamplermethod) {
                    "GET" { 
                        $httpssamplerresponsecode = "200"
                        $httpsampler_temp = $httpsampler_temp -replace 'httpsampler_contenttype', ""
                    }
                    "POST" { 
                        $httpssamplerresponsecode = "201"
                        $httpsampler_temp = $httpsampler_temp -replace 'httpsampler_contenttype', $contenttype
                     }
                     "PUT" { 
                        $httpssamplerresponsecode = "200"
                        $httpsampler_temp = $httpsampler_temp -replace 'httpsampler_contenttype', $contenttype
                     }
                    "DELETE" { 
                        $httpssamplerresponsecode = "204"
                     }
                    Default {
                        $httpssamplerresponsecode = "200"
                    }
                }
                $httpsampler_temp = $httpsampler_temp -replace 'httpsampler_path', $httpsamplerpath
                $httpsampler_temp = $httpsampler_temp -replace 'httpsampler_summary', "API - $httpsamplersummary"
                $httpsampler_temp = $httpsampler_temp -replace 'httpsampler_method', $httpsamplermethod
                $httpsampler_temp = $httpsampler_temp -replace 'httpsampler_responsecode', $httpssamplerresponsecode
                $httpsampler_temp = $httpsampler_temp -replace 'httpsampler_schemes', ${schemes}
                $httpsampler_temp = $httpsampler_temp -replace '$basepath', ${basepath}
                # Write-Output $httpsampler
                $finaljmx = $finaljmx + $httpsampler_temp
            }
        }
    }    
}
$finaljmx = $finaljmx -replace 'httpsampler_basepath', $basepath
# Write-Output $basepath
$finaljmx = $finaljmx + "</hashTree>"+$endpart
$newtemplate = $finaljmx -replace '\$\''\{', '${'
# Write the final JMX content to a file
#Write Complete JMX to UTF-8 encoded format direct writting is giving this error - 
# only whitespace content allowed before start tag and not \ufffd (position: START_DOCUMENT seen \ufffd... @1:2
[System.IO.File]::WriteAllLines($dir,$newtemplate)

# ##########################################################################################
# ##########################################################################################
#
Write-Output "***********************************************************"
Write-Output "JMX from swagger created in this location - "$dir
Write-Output "***********************************************************"