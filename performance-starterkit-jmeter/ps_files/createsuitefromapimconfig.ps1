Write-Output "`n`n**** JMeter suite creation with APIM - True ****"
Write-Output "              Creating JMeter Suite from APIM               "

$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
$dir = Split-Path -Path $dir -Parent


if ($ENV:OS -match "Windows") {
    # Write-Host "Windows"
    $dir = $dir+"\results\jmetersuitefromapimconfig.jmx"
}
else {
    # Write-Host "Linux"
    $dir = $dir+"/results/jmetersuitefromapimconfig.jmx"
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
          httpsampler_payload
          <stringProp name="HTTPSampler.domain">httpsampler_basepath</stringProp>
          <stringProp name="HTTPSampler.port"></stringProp>
          <stringProp name="HTTPSampler.protocol">httpsampler_scheme</stringProp>
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
              httpsampler_authheader
              httpsampler_ocpapimsubscriptionkey
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

$httppayload = @"
      <boolProp name="HTTPSampler.postBodyRaw">true</boolProp>
          <elementProp name="HTTPsampler.Arguments" elementType="Arguments">
            <collectionProp name="Arguments.arguments">
              <elementProp name="" elementType="HTTPArgument">
                <boolProp name="HTTPArgument.always_encode">false</boolProp>
                <stringProp name="Argument.value">httppayloadbody</stringProp>
                <stringProp name="Argument.metadata">=</stringProp>
              </elementProp>
            </collectionProp>
          </elementProp>
"@

$Content_Type = @"
        <elementProp name="Content-Type" elementType="Header">
            <stringProp name="Header.name">Content-Type</stringProp>
            <stringProp name="Header.value">application/json</stringProp>
        </elementProp>
"@ 

$Authorization_Header = @"
        <elementProp name="Authorization" elementType="Header">
            <stringProp name="Header.name">Authorization</stringProp>
            <stringProp name="Header.value">Bearer token</stringProp>
        </elementProp>
"@

$Ocp_Apim_Subscription_Key = @"
        <elementProp name="Authorization" elementType="Header">
            <stringProp name="Header.name">Ocp-Apim-Subscription-Key</stringProp>
            <stringProp name="Header.value"></stringProp>
        </elementProp>
"@

$jsonFilePath = $apimconfigpath
Write-Output "apim config file Path = $jsonFilePath"

# Read the JSON file content
$apimContent = Get-Content -Path $jsonFilePath -Raw

# Split the content into words and create a comma-separated string
$wordsArray = $apimContent -split '\s+'
# $commaSeparatedString = $wordsArray -join ','

# Parse text file and based on GET, POST, PUT, DELETE method create array of strings with content
$methodArray = @()
$tempstring = ""
foreach ($word in $wordsArray) {
    # Write-Output "***** = $word"
    # $tempstring += " " + $word
    
      if ($word.ToUpper() -eq "GET" -or $word.ToUpper() -eq "POST" -or $word.ToUpper() -eq "PUT" -or $word.ToUpper() -eq "DELETE") {
          if($tempstring -gt "GET" -or $tempstring -gt "POST" -or $tempstring -gt "PUT" -or $tempstring -gt "DELETE") {
            $methodArray += $tempstring
              $tempstring = $word +"_"
          }
          else {
              $tempstring += $word +"_"
          }
      }
      else {
        if($word -eq ""){ # means End of File #
          $methodArray += $tempstring
        }  
        else {
          $tempstring += $word +"_"
          # Write-Output "TempString = $tempstring"
        }
      }
}
if($tempstring.Length -ge 30)
{
    $methodArray += $tempstring
}

$startingpart = $startingpart -replace 'jmeter="5.5"', "jmeter=`"$jmeterversion`""
$finaljmx = $startingpart + $userdefinedvariable + $threadgroup +"<hashTree>"
$schemes = "https"
$httpsampler = $httpsampler -replace 'httpsampler_scheme', $schemes

# Output the method array
foreach ($method in $methodArray) {
    $httpsampler_temp = $httpsampler
    $httppayload_temp = $httppayload
    # Write-Output "Method: $method"
    $httpsamplermethod = ($method -split '_')[0].ToUpper()
    $httpssamplerresponsecode = ""
    $basepath = ((($method -split '_Host:_')[1]) -split '_')[0]
    $payload = ""
    if($method.ToLower().IndexOf("authorization") -gt 1)
    {
      $httpsampler_temp = $httpsampler -replace "httpsampler_authheader", $Authorization_Header
    } 
    else {
      $httpsampler_temp = $httpsampler -replace "httpsampler_authheader", ""
    }
    
    if($method.ToLower().IndexOf("ocp-apim-subscription-key") -gt 1)
    {
      $httpsampler_temp = $httpsampler -replace "httpsampler_ocpapimsubscriptionkey", $Ocp_Apim_Subscription_Key
    } 
    else {
      $httpsampler_temp = $httpsampler -replace "httpsampler_ocpapimsubscriptionkey", ""
    }


    if($method.IndexOf('_{') -gt 1) 
    {
      $payload_index = ($method -split '_{').Length-1
      $payload = "{"+($method -split '_{')[$payload_index].Replace("_", "")
      $httppayload_temp = $httppayload -replace "httppayloadbody", $payload
      $httpsampler_temp = $httpsampler -replace "httpsampler_payload", $httppayload_temp
    }
    $httpsamplerpath = ($method -split '_')[1].Replace($schemes+"://","")
    $httpsamplerpath = $httpsamplerpath.Replace($basepath,"")

    switch ($httpsamplermethod) {
        "GET" { 
            $httpssamplerresponsecode = "200"
            $httpsampler_temp = $httpsampler_temp -replace "httpsampler_contenttype", ""
            # $httpsampler_temp = $httpsampler_temp -replace "httpsampler_payload", ""
          }
        "POST" { 
            $httpssamplerresponsecode = "201"
            if(($method.IndexOf("Content-Type") -gt 1) -or ($method.IndexOf("application/json") -gt 1)) {
              $httpsampler_temp = $httpsampler_temp -replace "httpsampler_contenttype",$Content_Type
              
            }
            if($payload.Length -gt 5) {
              $httpsampler_temp = $httpsampler_temp -replace "httpsampler_payload", $payload 
            }
            else {
              $httpsampler_temp = $httpsampler_temp -replace "httpsampler_payload", "" 
            }
          }
        "PUT" { 
          $httpssamplerresponsecode = "200"
          if(($method.IndexOf("Content-Type") -gt 1) -or ($method.IndexOf("application/json") -gt 1)) {
            $httpsampler_temp = $httpsampler_temp -replace "httpsampler_contenttype", $Content_Type 
          }
          if($payload.Length -gt 5) {
            $httpsampler_temp = $httpsampler_temp -replace "httpsampler_payload", $payload 
          }
          else {
            $httpsampler_temp = $httpsampler_temp -replace "httpsampler_payload", "" 
          }
        }
        "DELETE" { 
            $httpssamplerresponsecode = "204"
          }
        Default {
            $httpssamplerresponsecode = "200"
        }
    }

    $httpsampler_temp = $httpsampler_temp -replace 'httpsampler_path', $httpsamplerpath
    $httpsampler_temp = $httpsampler_temp -replace 'httpsampler_basepath', $basepath
    $httpsampler_temp = $httpsampler_temp -replace 'httpsampler_summary', "API - $httpsamplerpath"
    $httpsampler_temp = $httpsampler_temp -replace 'httpsampler_method', $httpsamplermethod
    $httpsampler_temp = $httpsampler_temp -replace 'httpsampler_responsecode', $httpssamplerresponsecode
    $finaljmx = $finaljmx + $httpsampler_temp
}              
   
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
Write-Output "JMX from apim config created in this location - "$dir
Write-Output "***********************************************************"