# Write-Output "`n`n***********************************************************"
Write-Output "Now creating JMeter Master Script template"
# Write-Output "***********************************************************"
# Start-Sleep -Seconds 2

$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
$dir = Split-Path -Path $dir -Parent

## Checking the OS ##
if ($ENV:OS -match "Windows") {
    # Write-Host "Windows"
    $dir = $dir+"\results\jmeter_generic_template.jmx"
}
else {
    # Write-Host "Linux"
    $dir = $dir+"/jmetertemplate.jmx"
}

# ##########################################################################################
#Create a jmeter xml for hitting 1 API with User defined variable
$template = @"
<?xml version="1.0" encoding="UTF-8"?>
<jmeterTestPlan version="1.2" properties="5.0" jmeter="5.5">
  <hashTree>
    <TestPlan guiclass="TestPlanGui" testclass="TestPlan" testname="JMeter Generic template">
      <elementProp name="TestPlan.user_defined_variables" elementType="Arguments" guiclass="ArgumentsPanel" testclass="Arguments" testname="User Defined Variables">
        <collectionProp name="Arguments.arguments"/>
      </elementProp>
      <boolProp name="TestPlan.functional_mode">false</boolProp>
      <boolProp name="TestPlan.serialize_threadgroups">false</boolProp>
    </TestPlan>
    <hashTree>
      <Arguments guiclass="ArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
        <collectionProp name="Arguments.arguments">
          <elementProp name="protocol" elementType="Argument">
            <stringProp name="Argument.name">protocol</stringProp>
            <stringProp name="Argument.value">https</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="basepath" elementType="Argument">
            <stringProp name="Argument.name">basepath</stringProp>
            <stringProp name="Argument.value">www.bing.com</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="totaluserload" elementType="Argument">
            <stringProp name="Argument.name">totaluserload</stringProp>
            <stringProp name="Argument.value">100</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="anonymous" elementType="Argument">
            <stringProp name="Argument.name">anonymous</stringProp>
            <stringProp name="Argument.value">80</stringProp>
            <stringProp name="Argument.desc">this is percentage of totaluserload</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="registered" elementType="Argument">
            <stringProp name="Argument.name">registered</stringProp>
            <stringProp name="Argument.value">20</stringProp>
            <stringProp name="Argument.desc">this is percentage of totaluserload</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="username" elementType="Argument">
            <stringProp name="Argument.name">username</stringProp>
            <stringProp name="Argument.value">sampleusername</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="password" elementType="Argument">
            <stringProp name="Argument.name">password</stringProp>
            <stringProp name="Argument.value">samplepassword</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="influxdburl" elementType="Argument">
            <stringProp name="Argument.name">influxdburl</stringProp>
            <stringProp name="Argument.value">http://host_to_change:8086/write?db=jmeter</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="appinsightconnectionstring" elementType="Argument">
            <stringProp name="Argument.name">appinsightconnectionstring</stringProp>
            <stringProp name="Argument.value">InstrumentationKey=XXXXX;IngestionEndpoint=XXXX;LiveEndpoint=XXXX;ApplicationId=XXXX</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
            <stringProp name="Argument.desc">Copy the connection String from application insight</stringProp>
          </elementProp>
          <elementProp name="dbconnectionstring" elementType="Argument">
            <stringProp name="Argument.name">dbconnectionstring</stringProp>
            <stringProp name="Argument.value">connectionstring</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="databricksurl" elementType="Argument">
            <stringProp name="Argument.name">databricksurl</stringProp>
            <stringProp name="Argument.value">https://databricksurl</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="databricksjobid" elementType="Argument">
            <stringProp name="Argument.name">databricksjobid</stringProp>
            <stringProp name="Argument.value">16983123</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
            <stringProp name="Argument.desc">Numeric Value</stringProp>
          </elementProp>
          <elementProp name="cookiesgenerator" elementType="Argument">
            <stringProp name="Argument.name">cookiesgenerator</stringProp>
            <stringProp name="Argument.value">false</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="databrick_autorizationtoken" elementType="Argument">
            <stringProp name="Argument.name">databrick_autorizationtoken</stringProp>
            <stringProp name="Argument.value">Bearer XXXX</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="way1_ifcondition" elementType="Argument">
            <stringProp name="Argument.name">way1_ifcondition</stringProp>
            <stringProp name="Argument.value">true</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="way2_total_count_ifcondition" elementType="Argument">
            <stringProp name="Argument.name">way2_total_count_ifcondition</stringProp>
            <stringProp name="Argument.value">2</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
        </collectionProp>
      </Arguments>
      <hashTree/>
      <Arguments guiclass="ArgumentsPanel" testclass="Arguments" testname="POM variables" enabled="true">
        <collectionProp name="Arguments.arguments">
          <elementProp name="login_icon_xpath" elementType="Argument">
            <stringProp name="Argument.name">login_icon_xpath</stringProp>
            <stringProp name="Argument.value">&quot;//*[@id=\&quot;basic-navbar-nav\&quot;]/div/ul/li[4]&quot;</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="login_button_xpath" elementType="Argument">
            <stringProp name="Argument.name">login_button_xpath</stringProp>
            <stringProp name="Argument.value">&quot;//*[@id=\&quot;basic-navbar-nav\&quot;]/div/ul/li[4]/form/div/button&quot;</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="host" elementType="Argument">
            <stringProp name="Argument.name">host</stringProp>
            <stringProp name="Argument.value">samplehosturl</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="emailid" elementType="Argument">
            <stringProp name="Argument.name">emailid</stringProp>
            <stringProp name="Argument.value">sampleemailid</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="password" elementType="Argument">
            <stringProp name="Argument.name">password</stringProp>
            <stringProp name="Argument.value">&quot;//*[@name=\&quot;Password\&quot;]&quot;</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="username_xpath" elementType="Argument">
            <stringProp name="Argument.name">username_xpath</stringProp>
            <stringProp name="Argument.value">&quot;//*[@name=\&quot;Username or email address\&quot;]&quot;</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="submit_xpath" elementType="Argument">
            <stringProp name="Argument.name">submit_xpath</stringProp>
            <stringProp name="Argument.value">&quot;//*[@id=\&quot;next\&quot;]&quot;</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="redirectlink_xpath" elementType="Argument">
            <stringProp name="Argument.name">redirectlink_xpath</stringProp>
            <stringProp name="Argument.value">&quot;//*[@id=\&quot;redirect\&quot;]&quot;</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="formauthentication_xpath" elementType="Argument">
            <stringProp name="Argument.name">formauthentication_xpath</stringProp>
            <stringProp name="Argument.value">&quot;//*[@type=\&quot;form\&quot;]&quot;</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="password_xpath" elementType="Argument">
            <stringProp name="Argument.name">password_xpath</stringProp>
            <stringProp name="Argument.value">&quot;//*[@name=\&quot;Password\&quot;]&quot;</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="submitbutton_xpath" elementType="Argument">
            <stringProp name="Argument.name">submitbutton_xpath</stringProp>
            <stringProp name="Argument.value">&quot;//*[@id=\&quot;submit\&quot;]&quot;</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
          <elementProp name="passwordinput_xpath" elementType="Argument">
            <stringProp name="Argument.name">passwordinput_xpath</stringProp>
            <stringProp name="Argument.value">&quot;//*[@name=\&quot;Passwordinput\&quot;]&quot;</stringProp>
            <stringProp name="Argument.metadata">=</stringProp>
          </elementProp>
        </collectionProp>
        <stringProp name="TestPlan.comments">Only For Perf UI Testing</stringProp>
      </Arguments>
      <hashTree/>
      <SetupThreadGroup guiclass="SetupThreadGroupGui" testclass="SetupThreadGroup" testname="**** setUp Thread Group ****" enabled="true">
        <stringProp name="TestPlan.comments">This ThreadGroup will be always execute 1st. Pre-Requisite step which need to be run only once can be mentioned in this Thread Group</stringProp>
        <stringProp name="ThreadGroup.num_threads">1</stringProp>
        <stringProp name="ThreadGroup.ramp_time">1</stringProp>
        <boolProp name="ThreadGroup.same_user_on_next_iteration">true</boolProp>
        <stringProp name="ThreadGroup.on_sample_error">continue</stringProp>
        <elementProp name="ThreadGroup.main_controller" elementType="LoopController" guiclass="LoopControlPanel" testclass="LoopController" testname="Loop Controller" enabled="true">
          <boolProp name="LoopController.continue_forever">false</boolProp>
          <stringProp name="LoopController.loops">1</stringProp>
        </elementProp>
        <boolProp name="ThreadGroup.scheduler">false</boolProp>
        <stringProp name="ThreadGroup.duration"></stringProp>
        <stringProp name="ThreadGroup.delay"></stringProp>
      </SetupThreadGroup>
      <hashTree>
        <JSR223Sampler guiclass="TestBeanGUI" testclass="JSR223Sampler" testname="Percentage Calculator" enabled="true">
          <stringProp name="scriptLanguage">beanshell</stringProp>
          <stringProp name="parameters"></stringProp>
          <stringProp name="filename"></stringProp>
          <stringProp name="cacheKey">true</stringProp>
          <stringProp name="script">/**
 	Mobile: 60-70% (users browsing on smartphones and tablets) 
	Web: 30-40% (users browsing on laptops and desktops) 
	Anonymous: 80-90% (visitors exploring general information) 
	Registered: 10-20% (members accessing personalized features, bookings, etc.) 
 */
import org.apache.jmeter.util.JMeterUtils;

// Set all number //
int anonymous_user = Integer.parseInt(totaluserload)*Integer.parseInt(anonymous)/100;
int anonymous_mobile_user = anonymous_user*Integer.parseInt(anonymous)/100;
JMeterUtils.setProperty(&quot;anonymousmobileuser&quot;, &quot;&quot;+anonymous_mobile_user);
int anonymous_web_user = anonymous_user*Integer.parseInt(anonymous)/100;
JMeterUtils.setProperty(&quot;anonymouswebuser&quot;, &quot;&quot;+anonymous_web_user);
int registered_user = Integer.parseInt(totaluserload)*Integer.parseInt(registereduser)/100;
JMeterUtils.setProperty(&quot;registereduserthread&quot;, &quot;&quot;+registered_user);

log.info(&quot;Total User hit = &quot;);
log.info(&quot;Total Anonymous User = &quot;+anonymous_user+&quot; out of which mobile Users are = &quot;+anonymous_mobile_user+&quot; and Web Users are = &quot;+anonymous_web_user);
</stringProp>
          <stringProp name="TestPlan.comments">Let say if total User is 100 and anonymous % is 80 and registered user is 20% so this will be calculated in this sampler</stringProp>
        </JSR223Sampler>
        <hashTree/>
        <JSR223Sampler guiclass="TestBeanGUI" testclass="JSR223Sampler" testname="Base64 Encoding" enabled="true">
          <stringProp name="scriptLanguage">beanshell</stringProp>
          <stringProp name="parameters"></stringProp>
          <stringProp name="filename"></stringProp>
          <stringProp name="cacheKey">true</stringProp>
          <stringProp name="script">import org.apache.jmeter.util.JMeterUtils;

// Creating Basic Authorization //
import org.apache.commons.codec.binary.Base64;
String username = &quot;&quot;;
String password = &quot;&quot;;
String credentials = username + &quot;:&quot; + password;
byte[] encodedUsernamePassword = Base64.encodeBase64(credentials.getBytes());
JMeterUtils.setProperty(&quot;base64Credentials&quot;, new String(encodedUsernamePassword));
</stringProp>
          <stringProp name="TestPlan.comments">This is reference of generating Base64 credentials for username and password</stringProp>
        </JSR223Sampler>
        <hashTree/>
        <JSR223Sampler guiclass="TestBeanGUI" testclass="JSR223Sampler" testname="Setting User Agent" enabled="true">
          <stringProp name="scriptLanguage">beanshell</stringProp>
          <stringProp name="parameters"></stringProp>
          <stringProp name="filename"></stringProp>
          <stringProp name="cacheKey">true</stringProp>
          <stringProp name="script">// Set User Agent//
JMeterUtils.setProperty(&quot;mobileuseragent&quot;,&quot;Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36&quot;);
JMeterUtils.setProperty(&quot;webuseragent&quot;,&quot;Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36&quot;);</stringProp>
          <stringProp name="TestPlan.comments">This is for specifying User Agent to be used in the execution</stringProp>
        </JSR223Sampler>
        <hashTree/>
      </hashTree>
      <ThreadGroup guiclass="ThreadGroupGui" testclass="ThreadGroup" testname="Thread Group - Generic " enabled="false">
        <stringProp name="TestPlan.comments">HTTP Sampler , Loop , If Condition , Re-Run on condition , URL encoder and decoder</stringProp>
        <stringProp name="ThreadGroup.num_threads">1</stringProp>
        <stringProp name="ThreadGroup.ramp_time">1</stringProp>
        <boolProp name="ThreadGroup.same_user_on_next_iteration">true</boolProp>
        <stringProp name="ThreadGroup.on_sample_error">continue</stringProp>
        <elementProp name="ThreadGroup.main_controller" elementType="LoopController" guiclass="LoopControlPanel" testclass="LoopController" testname="Loop Controller" enabled="true">
          <boolProp name="LoopController.continue_forever">false</boolProp>
          <stringProp name="LoopController.loops">1</stringProp>
        </elementProp>
        <boolProp name="ThreadGroup.scheduler">false</boolProp>
        <stringProp name="ThreadGroup.duration"></stringProp>
        <stringProp name="ThreadGroup.delay"></stringProp>
      </ThreadGroup>
      <hashTree>
        <HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="HTTP Sampler" enabled="false">
          <elementProp name="HTTPsampler.Arguments" elementType="Arguments" guiclass="HTTPArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
            <collectionProp name="Arguments.arguments"/>
          </elementProp>
          <stringProp name="HTTPSampler.domain">$'{basepath}</stringProp>
          <stringProp name="HTTPSampler.port"></stringProp>
          <stringProp name="HTTPSampler.protocol">$'{protocol}</stringProp>
          <stringProp name="HTTPSampler.contentEncoding"></stringProp>
          <stringProp name="HTTPSampler.path">/search?q=jmeter</stringProp>
          <stringProp name="HTTPSampler.method">GET</stringProp>
          <boolProp name="HTTPSampler.follow_redirects">true</boolProp>
          <boolProp name="HTTPSampler.auto_redirects">false</boolProp>
          <boolProp name="HTTPSampler.use_keepalive">true</boolProp>
          <boolProp name="HTTPSampler.DO_MULTIPART_POST">false</boolProp>
          <stringProp name="HTTPSampler.embedded_url_re"></stringProp>
          <stringProp name="HTTPSampler.connect_timeout"></stringProp>
          <stringProp name="HTTPSampler.response_timeout"></stringProp>
          <stringProp name="TestPlan.comments">Update the protocol , Basepath and Resource Path</stringProp>
        </HTTPSamplerProxy>
        <hashTree/>
        <LoopController guiclass="LoopControlPanel" testclass="LoopController" testname="Loop Controller" enabled="false">
          <boolProp name="LoopController.continue_forever">true</boolProp>
          <stringProp name="LoopController.loops">100</stringProp>
        </LoopController>
        <hashTree>
          <HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="Bing Test" enabled="true">
            <elementProp name="HTTPsampler.Arguments" elementType="Arguments" guiclass="HTTPArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
              <collectionProp name="Arguments.arguments"/>
            </elementProp>
            <stringProp name="HTTPSampler.domain">$'{basepath}</stringProp>
            <stringProp name="HTTPSampler.port"></stringProp>
            <stringProp name="HTTPSampler.protocol">$'{protocol}</stringProp>
            <stringProp name="HTTPSampler.contentEncoding"></stringProp>
            <stringProp name="HTTPSampler.path">/search?q=perftest</stringProp>
            <stringProp name="HTTPSampler.method">GET</stringProp>
            <boolProp name="HTTPSampler.follow_redirects">true</boolProp>
            <boolProp name="HTTPSampler.auto_redirects">false</boolProp>
            <boolProp name="HTTPSampler.use_keepalive">true</boolProp>
            <boolProp name="HTTPSampler.DO_MULTIPART_POST">false</boolProp>
            <stringProp name="HTTPSampler.embedded_url_re"></stringProp>
            <stringProp name="HTTPSampler.connect_timeout"></stringProp>
            <stringProp name="HTTPSampler.response_timeout"></stringProp>
            <stringProp name="TestPlan.comments">Update the protocol , Basepath and Resource Path</stringProp>
          </HTTPSamplerProxy>
          <hashTree/>
        </hashTree>
        <GenericController guiclass="LogicControllerGui" testclass="GenericController" testname="External Jar Invoke" enabled="false">
          <stringProp name="TestPlan.comments">For Reference : https://www.linkedin.com/pulse/using-custom-jar-beanshell-sampler-jmeter-lakshmi-narayan/</stringProp>
        </GenericController>
        <hashTree>
          <BeanShellSampler guiclass="BeanShellSamplerGui" testclass="BeanShellSampler" testname="Invoke Jar - 1 " enabled="true">
            <stringProp name="TestPlan.comments">Import jar in the test plan or in the run time with cmd line arguments.</stringProp>
            <stringProp name="BeanShellSampler.query">import FactClass.Fact;

Fact fac = new Fact();

int result=fac.facto(Integer.parseInt(vars.get(&quot;num&quot;)));

vars.put(&quot;result&quot;,result.toString());

print(&quot;Factorial of &quot; + vars.get(&quot;num&quot;) + &quot; = &quot; + vars.get(&quot;result&quot;));

log.info(&quot;Factorial of &quot; + vars.get(&quot;num&quot;) + &quot; = &quot; + vars.get(&quot;result&quot;));</stringProp>
            <stringProp name="BeanShellSampler.filename"></stringProp>
            <stringProp name="BeanShellSampler.parameters"></stringProp>
            <boolProp name="BeanShellSampler.resetInterpreter">false</boolProp>
          </BeanShellSampler>
          <hashTree/>
        </hashTree>
        <GenericController guiclass="LogicControllerGui" testclass="GenericController" testname="Re-Run way for a period of time" enabled="false">
          <stringProp name="TestPlan.comments">Control on Conditonal Flow , Loop , desired duration</stringProp>
        </GenericController>
        <hashTree>
          <BeanShellSampler guiclass="BeanShellSamplerGui" testclass="BeanShellSampler" testname="TimerCheck &gt;= 10 sec" enabled="true">
            <stringProp name="BeanShellSampler.query">props.put(&quot;stillwait&quot;,&quot;true&quot;);</stringProp>
            <stringProp name="BeanShellSampler.filename"></stringProp>
            <stringProp name="BeanShellSampler.parameters"></stringProp>
            <boolProp name="BeanShellSampler.resetInterpreter">true</boolProp>
          </BeanShellSampler>
          <hashTree/>
          <WhileController guiclass="WhileControllerGui" testclass="WhileController" testname="While Controller" enabled="true">
            <stringProp name="WhileController.condition">$'{__jexl3($'{__P(stillwait)}==&quot;true&quot;)}</stringProp>
          </WhileController>
          <hashTree>
            <ConstantTimer guiclass="ConstantTimerGui" testclass="ConstantTimer" testname="Wait for 1 sec" enabled="true">
              <stringProp name="ConstantTimer.delay">1000</stringProp>
            </ConstantTimer>
            <hashTree/>
            <BeanShellSampler guiclass="BeanShellSamplerGui" testclass="BeanShellSampler" testname="TimerCheck &gt;= 10 sec" enabled="true">
              <stringProp name="BeanShellSampler.query">int stime = Integer.valueOf(props.get(&quot;StartTime&quot;));
log.info(&quot;Start Time = &quot;+stime);
int difference = (-stime);
log.info(&quot;Difference = &quot;+difference);
//log.info(&quot;Difference 2 &quot;+(difference&lt;));
if(difference&lt;) //
{
	props.put(&quot;stillwait&quot;,&quot;true&quot;);
	
}
else
{
	log.info(&quot;&quot;);
	props.put(&quot;stillwait&quot;,&quot;false&quot;);
}

</stringProp>
              <stringProp name="BeanShellSampler.filename"></stringProp>
              <stringProp name="BeanShellSampler.parameters"></stringProp>
              <boolProp name="BeanShellSampler.resetInterpreter">true</boolProp>
            </BeanShellSampler>
            <hashTree/>
          </hashTree>
        </hashTree>
        <GenericController guiclass="LogicControllerGui" testclass="GenericController" testname="URL Encoder and Decoder " enabled="false"/>
        <hashTree>
          <JSR223Sampler guiclass="TestBeanGUI" testclass="JSR223Sampler" testname="JSR223 Sampler" enabled="true">
            <stringProp name="cacheKey">true</stringProp>
            <stringProp name="filename"></stringProp>
            <stringProp name="parameters"></stringProp>
            <stringProp name="script">import java.net.URLEncoder;
import java.net.URLDecoder

String enddate= &quot;The string is @foo-bar&quot;;
String encodedstring,decodedstring;
encodedstring=URLEncoder.encode(enddate, &quot;UTF-8&quot;);  // encodes string into enc scheme
decodedstring=URLDecoder.decode(encodedstring, &quot;UTF-8&quot;);  // decodes string
log.info(encodedstring+&quot;,&quot;+decodedstring);
vars.put(&quot;encodedstring&quot;,encodedstring);
vars.put(&quot;decodedstring&quot;,decodedstring);</stringProp>
            <stringProp name="scriptLanguage">groovy</stringProp>
          </JSR223Sampler>
          <hashTree/>
        </hashTree>
        <GenericController guiclass="LogicControllerGui" testclass="GenericController" testname="If Condition" enabled="false"/>
        <hashTree>
          <IfController guiclass="IfControllerPanel" testclass="IfController" testname="If Controller - Way1" enabled="true">
            <stringProp name="IfController.condition">$'{way1_ifcondition}</stringProp>
            <boolProp name="IfController.evaluateAll">false</boolProp>
            <boolProp name="IfController.useExpression">true</boolProp>
          </IfController>
          <hashTree>
            <JSR223Sampler guiclass="TestBeanGUI" testclass="JSR223Sampler" testname="Response Check" enabled="true">
              <stringProp name="scriptLanguage">groovy</stringProp>
              <stringProp name="parameters"></stringProp>
              <stringProp name="filename"></stringProp>
              <stringProp name="cacheKey">false</stringProp>
              <stringProp name="script">String prevResponse = ctx.getPreviousResult().getResponseDataAsString();
log.info(preResponse)</stringProp>
            </JSR223Sampler>
            <hashTree/>
          </hashTree>
          <IfController guiclass="IfControllerPanel" testclass="IfController" testname="If Controller - Way2" enabled="true">
            <stringProp name="IfController.condition">$'{__jexl3($'{total_count_ifcondition} &lt;= 2,)}</stringProp>
            <boolProp name="IfController.evaluateAll">false</boolProp>
            <boolProp name="IfController.useExpression">true</boolProp>
          </IfController>
          <hashTree>
            <JSR223Sampler guiclass="TestBeanGUI" testclass="JSR223Sampler" testname="Response Check" enabled="true">
              <stringProp name="scriptLanguage">groovy</stringProp>
              <stringProp name="parameters"></stringProp>
              <stringProp name="filename"></stringProp>
              <stringProp name="cacheKey">false</stringProp>
              <stringProp name="script">String prevResponse = ctx.getPreviousResult().getResponseDataAsString();
log.info(preResponse)</stringProp>
            </JSR223Sampler>
            <hashTree/>
          </hashTree>
        </hashTree>
        <GenericController guiclass="LogicControllerGui" testclass="GenericController" testname="Assertions Sample" enabled="false"/>
        <hashTree>
          <HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="Duration Assertion" enabled="true">
            <elementProp name="HTTPsampler.Arguments" elementType="Arguments" guiclass="HTTPArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
              <collectionProp name="Arguments.arguments"/>
            </elementProp>
            <stringProp name="HTTPSampler.domain"></stringProp>
            <stringProp name="HTTPSampler.port"></stringProp>
            <stringProp name="HTTPSampler.protocol"></stringProp>
            <stringProp name="HTTPSampler.contentEncoding"></stringProp>
            <stringProp name="HTTPSampler.path">/search?q=jmeter</stringProp>
            <stringProp name="HTTPSampler.method">GET</stringProp>
            <boolProp name="HTTPSampler.follow_redirects">true</boolProp>
            <boolProp name="HTTPSampler.auto_redirects">false</boolProp>
            <boolProp name="HTTPSampler.use_keepalive">true</boolProp>
            <boolProp name="HTTPSampler.DO_MULTIPART_POST">false</boolProp>
            <stringProp name="HTTPSampler.embedded_url_re"></stringProp>
            <stringProp name="HTTPSampler.connect_timeout"></stringProp>
            <stringProp name="HTTPSampler.response_timeout"></stringProp>
            <stringProp name="TestPlan.comments">Update the protocol , Basepath and Resource Path</stringProp>
          </HTTPSamplerProxy>
          <hashTree>
            <DurationAssertion guiclass="DurationAssertionGui" testclass="DurationAssertion" testname="Duration Assertion" enabled="true">
              <stringProp name="TestPlan.comments">best Case - if we want to fail the response based on API ETA. If HTTP Sampler is not completed within 3 sec it will fail</stringProp>
              <stringProp name="DurationAssertion.duration">3000</stringProp>
            </DurationAssertion>
            <hashTree/>
          </hashTree>
          <HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="Response Assertion" enabled="true">
            <elementProp name="HTTPsampler.Arguments" elementType="Arguments" guiclass="HTTPArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
              <collectionProp name="Arguments.arguments"/>
            </elementProp>
            <stringProp name="HTTPSampler.domain"></stringProp>
            <stringProp name="HTTPSampler.port"></stringProp>
            <stringProp name="HTTPSampler.protocol"></stringProp>
            <stringProp name="HTTPSampler.contentEncoding"></stringProp>
            <stringProp name="HTTPSampler.path">/search?q=jmeter</stringProp>
            <stringProp name="HTTPSampler.method">GET</stringProp>
            <boolProp name="HTTPSampler.follow_redirects">true</boolProp>
            <boolProp name="HTTPSampler.auto_redirects">false</boolProp>
            <boolProp name="HTTPSampler.use_keepalive">true</boolProp>
            <boolProp name="HTTPSampler.DO_MULTIPART_POST">false</boolProp>
            <stringProp name="HTTPSampler.embedded_url_re"></stringProp>
            <stringProp name="HTTPSampler.connect_timeout"></stringProp>
            <stringProp name="HTTPSampler.response_timeout"></stringProp>
            <stringProp name="TestPlan.comments">Update the protocol , Basepath and Resource Path</stringProp>
          </HTTPSamplerProxy>
          <hashTree>
            <ResponseAssertion guiclass="AssertionGui" testclass="ResponseAssertion" testname="Response Assertion for Body text" enabled="true">
              <collectionProp name="Asserion.test_strings">
                <stringProp name="-202516509">Success</stringProp>
              </collectionProp>
              <stringProp name="Assertion.custom_message"></stringProp>
              <stringProp name="Assertion.test_field">Assertion.response_data</stringProp>
              <boolProp name="Assertion.assume_success">false</boolProp>
              <intProp name="Assertion.test_type">2</intProp>
            </ResponseAssertion>
            <hashTree/>
            <ResponseAssertion guiclass="AssertionGui" testclass="ResponseAssertion" testname="Response Assertion for Status Code" enabled="true">
              <collectionProp name="Asserion.test_strings">
                <stringProp name="49586">200</stringProp>
              </collectionProp>
              <stringProp name="Assertion.custom_message"></stringProp>
              <stringProp name="Assertion.test_field">Assertion.response_code</stringProp>
              <boolProp name="Assertion.assume_success">false</boolProp>
              <intProp name="Assertion.test_type">8</intProp>
            </ResponseAssertion>
            <hashTree/>
          </hashTree>
        </hashTree>
        <GenericController guiclass="LogicControllerGui" testclass="GenericController" testname="Extrator Sample" enabled="false"/>
        <hashTree>
          <HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="HTTP Sampler" enabled="false">
            <elementProp name="HTTPsampler.Arguments" elementType="Arguments" guiclass="HTTPArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
              <collectionProp name="Arguments.arguments"/>
            </elementProp>
            <stringProp name="HTTPSampler.domain">${basepath}</stringProp>
            <stringProp name="HTTPSampler.port"></stringProp>
            <stringProp name="HTTPSampler.protocol">${protocol}</stringProp>
            <stringProp name="HTTPSampler.contentEncoding"></stringProp>
            <stringProp name="HTTPSampler.path">/search?q=jmeter</stringProp>
            <stringProp name="HTTPSampler.method">GET</stringProp>
            <boolProp name="HTTPSampler.follow_redirects">true</boolProp>
            <boolProp name="HTTPSampler.auto_redirects">false</boolProp>
            <boolProp name="HTTPSampler.use_keepalive">true</boolProp>
            <boolProp name="HTTPSampler.DO_MULTIPART_POST">false</boolProp>
            <stringProp name="HTTPSampler.embedded_url_re"></stringProp>
            <stringProp name="HTTPSampler.connect_timeout"></stringProp>
            <stringProp name="HTTPSampler.response_timeout"></stringProp>
            <stringProp name="TestPlan.comments">Update the protocol , Basepath and Resource Path</stringProp>
          </HTTPSamplerProxy>
          <hashTree>
            <JSONPostProcessor guiclass="JSONPostProcessorGui" testclass="JSONPostProcessor" testname="JSON Extractor" enabled="true">
              <stringProp name="JSONPostProcessor.referenceNames">var1;var2</stringProp>
              <stringProp name="JSONPostProcessor.jsonPathExprs">$.keyname1;$.keyname2</stringProp>
              <stringProp name="JSONPostProcessor.match_numbers">1</stringProp>
              <stringProp name="Sample.scope">all</stringProp>
              <stringProp name="JSONPostProcessor.defaultValues">NOTFOUND</stringProp>
            </JSONPostProcessor>
            <hashTree/>
            <BoundaryExtractor guiclass="BoundaryExtractorGui" testclass="BoundaryExtractor" testname="Boundary Extractor" enabled="true">
              <stringProp name="BoundaryExtractor.useHeaders">false</stringProp>
              <stringProp name="BoundaryExtractor.refname">response</stringProp>
              <stringProp name="BoundaryExtractor.lboundary">&lt;!DOCTYPE</stringProp>
              <stringProp name="BoundaryExtractor.rboundary">&gt;&lt;html</stringProp>
              <stringProp name="BoundaryExtractor.default">NOTTFOUND</stringProp>
              <boolProp name="BoundaryExtractor.default_empty_value">false</boolProp>
              <stringProp name="BoundaryExtractor.match_number"></stringProp>
            </BoundaryExtractor>
            <hashTree/>
            <RegexExtractor guiclass="RegexExtractorGui" testclass="RegexExtractor" testname="Regular Expression Extractor" enabled="true">
              <stringProp name="TestPlan.comments">{&quot;ID&quot;:37035,&quot;FirstName&quot;:&quot;Tom&quot;,&quot;LastName&quot;:&quot;S&quot;,&quot;UserName&quot;:&quot;Tom&quot;,&quot;EmployeeID&quot;:&quot;EMP005150&quot;,&quot;ProgramID&quot;:&quot;311&quot;,&quot;ProgramRoleID&quot;:&quot;237&quot;}</stringProp>
              <stringProp name="RegexExtractor.useHeaders">false</stringProp>
              <stringProp name="RegexExtractor.refname">userid</stringProp>
              <stringProp name="RegexExtractor.regex">&quot;ID&quot;:(.*?),</stringProp>
              <stringProp name="RegexExtractor.template">$</stringProp>
              <stringProp name="RegexExtractor.default">NOTFOUND</stringProp>
              <stringProp name="RegexExtractor.match_number">1</stringProp>
            </RegexExtractor>
            <hashTree/>
            <XPathExtractor guiclass="XPathExtractorGui" testclass="XPathExtractor" testname="XPath Extractor" enabled="true">
              <stringProp name="TestPlan.comments">&lt;root xmlns:foo=&quot;http://www.foo.org/&quot; xmlns:bar=&quot;http://www.bar.org&quot;&gt;
  &lt;actors&gt;
    &lt;actor id=&quot;1&quot;&gt;Christian Bale&lt;/actor&gt;
    &lt;actor id=&quot;2&quot;&gt;Liam Neeson&lt;/actor&gt;
    &lt;actor id=&quot;3&quot;&gt;Michael Caine&lt;/actor&gt;
  &lt;/actors&gt;</stringProp>
              <stringProp name="XPathExtractor.default">NOTFOUND</stringProp>
              <stringProp name="XPathExtractor.refname">response</stringProp>
              <stringProp name="XPathExtractor.matchNumber">-1</stringProp>
              <stringProp name="XPathExtractor.xpathQuery">/root/actors/actor</stringProp>
              <boolProp name="XPathExtractor.validate">false</boolProp>
              <boolProp name="XPathExtractor.tolerant">false</boolProp>
              <boolProp name="XPathExtractor.namespace">false</boolProp>
            </XPathExtractor>
            <hashTree/>
          </hashTree>
        </hashTree>
      </hashTree>
      <ThreadGroup guiclass="ThreadGroupGui" testclass="ThreadGroup" testname="Thread Group - Constant Throughput Timer" enabled="false">
        <stringProp name="TestPlan.comments">This TG is for maintaining TPS to hit any service. Note: to control TPS we have to modify Thread properties with constant timer </stringProp>
        <stringProp name="ThreadGroup.num_threads">10</stringProp>
        <stringProp name="ThreadGroup.ramp_time">5</stringProp>
        <boolProp name="ThreadGroup.same_user_on_next_iteration">true</boolProp>
        <stringProp name="ThreadGroup.on_sample_error">continue</stringProp>
        <elementProp name="ThreadGroup.main_controller" elementType="LoopController" guiclass="LoopControlPanel" testclass="LoopController" testname="Loop Controller" enabled="true">
          <boolProp name="LoopController.continue_forever">false</boolProp>
          <stringProp name="LoopController.loops">10</stringProp>
        </elementProp>
        <boolProp name="ThreadGroup.scheduler">false</boolProp>
        <stringProp name="ThreadGroup.duration"></stringProp>
        <stringProp name="ThreadGroup.delay"></stringProp>
      </ThreadGroup>
      <hashTree>
        <HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="Dummy HTTP Sampler" enabled="true">
          <elementProp name="HTTPsampler.Arguments" elementType="Arguments" guiclass="HTTPArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
            <collectionProp name="Arguments.arguments"/>
          </elementProp>
          <stringProp name="HTTPSampler.domain"></stringProp>
          <stringProp name="HTTPSampler.port"></stringProp>
          <stringProp name="HTTPSampler.protocol"></stringProp>
          <stringProp name="HTTPSampler.contentEncoding"></stringProp>
          <stringProp name="HTTPSampler.path">/search?q=jmeter</stringProp>
          <stringProp name="HTTPSampler.method">GET</stringProp>
          <boolProp name="HTTPSampler.follow_redirects">true</boolProp>
          <boolProp name="HTTPSampler.auto_redirects">false</boolProp>
          <boolProp name="HTTPSampler.use_keepalive">true</boolProp>
          <boolProp name="HTTPSampler.DO_MULTIPART_POST">false</boolProp>
          <stringProp name="HTTPSampler.embedded_url_re"></stringProp>
          <stringProp name="HTTPSampler.connect_timeout"></stringProp>
          <stringProp name="HTTPSampler.response_timeout"></stringProp>
          <stringProp name="TestPlan.comments">Update the protocol , Basepath and Resource Path</stringProp>
        </HTTPSamplerProxy>
        <hashTree>
          <ConstantThroughputTimer guiclass="TestBeanGUI" testclass="ConstantThroughputTimer" testname="Constant Throughput Timer" enabled="true">
            <stringProp name="TestPlan.comments">300 sample is 1 min means - 5 Samples to be hit in 1 sec.</stringProp>
            <intProp name="calcMode">0</intProp>
            <doubleProp>
              <name>throughput</name>
              <value>300.0</value>
              <savedValue>0.0</savedValue>
            </doubleProp>
          </ConstantThroughputTimer>
          <hashTree/>
        </hashTree>
      </hashTree>
      <ThreadGroup guiclass="ThreadGroupGui" testclass="ThreadGroup" testname="Thread Group - Run all request in Parallel" enabled="false">
        <stringProp name="ThreadGroup.num_threads">1</stringProp>
        <stringProp name="ThreadGroup.ramp_time">1</stringProp>
        <boolProp name="ThreadGroup.same_user_on_next_iteration">true</boolProp>
        <stringProp name="ThreadGroup.on_sample_error">continue</stringProp>
        <elementProp name="ThreadGroup.main_controller" elementType="LoopController" guiclass="LoopControlPanel" testclass="LoopController" testname="Loop Controller" enabled="true">
          <boolProp name="LoopController.continue_forever">false</boolProp>
          <stringProp name="LoopController.loops">1</stringProp>
        </elementProp>
        <boolProp name="ThreadGroup.scheduler">false</boolProp>
        <stringProp name="ThreadGroup.duration"></stringProp>
        <stringProp name="ThreadGroup.delay"></stringProp>
      </ThreadGroup>
      <hashTree>
        <com.blazemeter.jmeter.controller.ParallelSampler guiclass="com.blazemeter.jmeter.controller.ParallelControllerGui" testclass="com.blazemeter.jmeter.controller.ParallelSampler" testname="bzm Parallel Controller" enabled="true">
          <intProp name="MAX_THREAD_NUMBER">6</intProp>
          <boolProp name="PARENT_SAMPLE">false</boolProp>
          <boolProp name="LIMIT_MAX_THREAD_NUMBER">false</boolProp>
        </com.blazemeter.jmeter.controller.ParallelSampler>
        <hashTree>
          <HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="HTTP Sampler 1" enabled="true">
            <elementProp name="HTTPsampler.Arguments" elementType="Arguments" guiclass="HTTPArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
              <collectionProp name="Arguments.arguments"/>
            </elementProp>
            <stringProp name="HTTPSampler.domain"></stringProp>
            <stringProp name="HTTPSampler.port"></stringProp>
            <stringProp name="HTTPSampler.protocol"></stringProp>
            <stringProp name="HTTPSampler.contentEncoding"></stringProp>
            <stringProp name="HTTPSampler.path">/search?q=jmeter</stringProp>
            <stringProp name="HTTPSampler.method">GET</stringProp>
            <boolProp name="HTTPSampler.follow_redirects">true</boolProp>
            <boolProp name="HTTPSampler.auto_redirects">false</boolProp>
            <boolProp name="HTTPSampler.use_keepalive">true</boolProp>
            <boolProp name="HTTPSampler.DO_MULTIPART_POST">false</boolProp>
            <stringProp name="HTTPSampler.embedded_url_re"></stringProp>
            <stringProp name="HTTPSampler.connect_timeout"></stringProp>
            <stringProp name="HTTPSampler.response_timeout"></stringProp>
            <stringProp name="TestPlan.comments">Update the protocol , Basepath and Resource Path</stringProp>
          </HTTPSamplerProxy>
          <hashTree/>
          <HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="HTTP Sampler 2" enabled="true">
            <elementProp name="HTTPsampler.Arguments" elementType="Arguments" guiclass="HTTPArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
              <collectionProp name="Arguments.arguments"/>
            </elementProp>
            <stringProp name="HTTPSampler.domain"></stringProp>
            <stringProp name="HTTPSampler.port"></stringProp>
            <stringProp name="HTTPSampler.protocol"></stringProp>
            <stringProp name="HTTPSampler.contentEncoding"></stringProp>
            <stringProp name="HTTPSampler.path">/search?q=gatlin</stringProp>
            <stringProp name="HTTPSampler.method">GET</stringProp>
            <boolProp name="HTTPSampler.follow_redirects">true</boolProp>
            <boolProp name="HTTPSampler.auto_redirects">false</boolProp>
            <boolProp name="HTTPSampler.use_keepalive">true</boolProp>
            <boolProp name="HTTPSampler.DO_MULTIPART_POST">false</boolProp>
            <stringProp name="HTTPSampler.embedded_url_re"></stringProp>
            <stringProp name="HTTPSampler.connect_timeout"></stringProp>
            <stringProp name="HTTPSampler.response_timeout"></stringProp>
            <stringProp name="TestPlan.comments">Update the protocol , Basepath and Resource Path</stringProp>
          </HTTPSamplerProxy>
          <hashTree/>
        </hashTree>
      </hashTree>
      <ThreadGroup guiclass="ThreadGroupGui" testclass="ThreadGroup" testname="Thread Group - CSV " enabled="false">
        <stringProp name="TestPlan.comments">if we keep Numbers of Thread, Ramp up and loop counter = 1 this will run on only first value. Check how many loop count or thread you have to use complete the CSV values</stringProp>
        <stringProp name="ThreadGroup.num_threads">1</stringProp>
        <stringProp name="ThreadGroup.ramp_time">1</stringProp>
        <boolProp name="ThreadGroup.same_user_on_next_iteration">true</boolProp>
        <stringProp name="ThreadGroup.on_sample_error">continue</stringProp>
        <elementProp name="ThreadGroup.main_controller" elementType="LoopController" guiclass="LoopControlPanel" testclass="LoopController" testname="Loop Controller" enabled="true">
          <boolProp name="LoopController.continue_forever">false</boolProp>
          <stringProp name="LoopController.loops">1</stringProp>
        </elementProp>
        <boolProp name="ThreadGroup.scheduler">false</boolProp>
        <stringProp name="ThreadGroup.duration"></stringProp>
        <stringProp name="ThreadGroup.delay"></stringProp>
      </ThreadGroup>
      <hashTree>
        <CSVDataSet guiclass="TestBeanGUI" testclass="CSVDataSet" testname="CSV Data Set Config" enabled="true">
          <stringProp name="TestPlan.comments">for ex: csvfile.csv have 2 column value comma seperated - username,password. in Thread Group uname,pswd can be used to call the values. Update the CSV Thread Group so that all the entries in csv can be used.</stringProp>
          <stringProp name="delimiter">,</stringProp>
          <stringProp name="fileEncoding"></stringProp>
          <stringProp name="filename">csvfile.csv</stringProp>
          <boolProp name="ignoreFirstLine">false</boolProp>
          <boolProp name="quotedData">false</boolProp>
          <boolProp name="recycle">true</boolProp>
          <stringProp name="shareMode">shareMode.all</stringProp>
          <boolProp name="stopThread">false</boolProp>
          <stringProp name="variableNames">uname,pswd</stringProp>
        </CSVDataSet>
        <hashTree/>
        <HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="Dummy HTTP Sampler" enabled="true">
          <elementProp name="HTTPsampler.Arguments" elementType="Arguments" guiclass="HTTPArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
            <collectionProp name="Arguments.arguments"/>
          </elementProp>
          <stringProp name="HTTPSampler.domain"></stringProp>
          <stringProp name="HTTPSampler.port"></stringProp>
          <stringProp name="HTTPSampler.protocol"></stringProp>
          <stringProp name="HTTPSampler.contentEncoding"></stringProp>
          <stringProp name="HTTPSampler.path">/search?q=jmeter</stringProp>
          <stringProp name="HTTPSampler.method">GET</stringProp>
          <boolProp name="HTTPSampler.follow_redirects">true</boolProp>
          <boolProp name="HTTPSampler.auto_redirects">false</boolProp>
          <boolProp name="HTTPSampler.use_keepalive">true</boolProp>
          <boolProp name="HTTPSampler.DO_MULTIPART_POST">false</boolProp>
          <stringProp name="HTTPSampler.embedded_url_re"></stringProp>
          <stringProp name="HTTPSampler.connect_timeout"></stringProp>
          <stringProp name="HTTPSampler.response_timeout"></stringProp>
          <stringProp name="TestPlan.comments">Update the protocol , Basepath and Resource Path</stringProp>
        </HTTPSamplerProxy>
        <hashTree/>
      </hashTree>
      <kg.apc.jmeter.threads.SteppingThreadGroup guiclass="kg.apc.jmeter.threads.SteppingThreadGroupGui" testclass="kg.apc.jmeter.threads.SteppingThreadGroup" testname="jp@gc - Stepping Thread Group" enabled="false">
        <stringProp name="TestPlan.comments">Case like Run with 100 Sample for 5 min and increase and reach to 500 Sample , Stay there for 10min and Stop thread after every x sec.</stringProp>
        <stringProp name="ThreadGroup.on_sample_error">continue</stringProp>
        <stringProp name="ThreadGroup.num_threads">100</stringProp>
        <stringProp name="Threads initial delay">0</stringProp>
        <stringProp name="Start users count">10</stringProp>
        <stringProp name="Start users count burst">0</stringProp>
        <stringProp name="Start users period">30</stringProp>
        <stringProp name="Stop users count">5</stringProp>
        <stringProp name="Stop users period">1</stringProp>
        <stringProp name="flighttime">60</stringProp>
        <stringProp name="rampUp">5</stringProp>
        <elementProp name="ThreadGroup.main_controller" elementType="LoopController" guiclass="LoopControlPanel" testclass="LoopController" testname="Loop Controller" enabled="true">
          <boolProp name="LoopController.continue_forever">false</boolProp>
          <intProp name="LoopController.loops">-1</intProp>
        </elementProp>
      </kg.apc.jmeter.threads.SteppingThreadGroup>
      <hashTree>
        <kg.apc.jmeter.vizualizers.CorrectedResultCollector guiclass="kg.apc.jmeter.vizualizers.TransactionsPerSecondGui" testclass="kg.apc.jmeter.vizualizers.CorrectedResultCollector" testname="jp@gc - Transactions per Second" enabled="true">
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
          <longProp name="interval_grouping">1000</longProp>
          <boolProp name="graph_aggregated">false</boolProp>
          <stringProp name="include_sample_labels"></stringProp>
          <stringProp name="exclude_sample_labels"></stringProp>
          <stringProp name="start_offset"></stringProp>
          <stringProp name="end_offset"></stringProp>
          <boolProp name="include_checkbox_state">false</boolProp>
          <boolProp name="exclude_checkbox_state">false</boolProp>
        </kg.apc.jmeter.vizualizers.CorrectedResultCollector>
        <hashTree/>
        <kg.apc.jmeter.vizualizers.CorrectedResultCollector guiclass="kg.apc.jmeter.vizualizers.HitsPerSecondGui" testclass="kg.apc.jmeter.vizualizers.CorrectedResultCollector" testname="jp@gc - Hits per Second" enabled="true">
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
          <longProp name="interval_grouping">1000</longProp>
          <boolProp name="graph_aggregated">false</boolProp>
          <stringProp name="include_sample_labels"></stringProp>
          <stringProp name="exclude_sample_labels"></stringProp>
          <stringProp name="start_offset"></stringProp>
          <stringProp name="end_offset"></stringProp>
          <boolProp name="include_checkbox_state">false</boolProp>
          <boolProp name="exclude_checkbox_state">false</boolProp>
        </kg.apc.jmeter.vizualizers.CorrectedResultCollector>
        <hashTree/>
      </hashTree>
      <ThreadGroup guiclass="ThreadGroupGui" testclass="ThreadGroup" testname="Thread Group - Throughput Shaping Timer (RPS)" enabled="false">
        <stringProp name="TestPlan.comments">Throughput Shaping Timer! Now you can just set schedule of RPS easily. Threads pool size can be calculated like RPS * &lt;max response time&gt; / 1000      For example, if your service response time may be 2.5sec and target rps is 1230, you have to have 1230 * 2500 / 1000 = 3075 threads.</stringProp>
        <stringProp name="ThreadGroup.num_threads">1</stringProp>
        <stringProp name="ThreadGroup.ramp_time">1</stringProp>
        <boolProp name="ThreadGroup.same_user_on_next_iteration">true</boolProp>
        <stringProp name="ThreadGroup.on_sample_error">continue</stringProp>
        <elementProp name="ThreadGroup.main_controller" elementType="LoopController" guiclass="LoopControlPanel" testclass="LoopController" testname="Loop Controller" enabled="true">
          <boolProp name="LoopController.continue_forever">false</boolProp>
          <stringProp name="LoopController.loops">1</stringProp>
        </elementProp>
        <boolProp name="ThreadGroup.scheduler">false</boolProp>
        <stringProp name="ThreadGroup.duration"></stringProp>
        <stringProp name="ThreadGroup.delay"></stringProp>
      </ThreadGroup>
      <hashTree>
        <kg.apc.jmeter.timers.VariableThroughputTimer guiclass="kg.apc.jmeter.timers.VariableThroughputTimerGui" testclass="kg.apc.jmeter.timers.VariableThroughputTimer" testname="jp@gc - Throughput Shaping Timer" enabled="true">
          <collectionProp name="load_profile">
            <collectionProp name="1800738992">
              <stringProp name="1">1</stringProp>
              <stringProp name="1000">1000</stringProp>
              <stringProp name="60">60</stringProp>
            </collectionProp>
            <collectionProp name="116882998">
              <stringProp name="1507423">1000</stringProp>
              <stringProp name="1537214">2000</stringProp>
              <stringProp name="60">60</stringProp>
            </collectionProp>
            <collectionProp name="-1313681290">
              <stringProp name="1537214">2000</stringProp>
              <stringProp name="1567005">3000</stringProp>
              <stringProp name="60">60</stringProp>
            </collectionProp>
            <collectionProp name="1526827414">
              <stringProp name="1567005">3000</stringProp>
              <stringProp name="1596796">4000</stringProp>
              <stringProp name="60">60</stringProp>
            </collectionProp>
          </collectionProp>
        </kg.apc.jmeter.timers.VariableThroughputTimer>
        <hashTree/>
      </hashTree>
      <ThreadGroup guiclass="ThreadGroupGui" testclass="ThreadGroup" testname="Thread Group - Grafana and Influx DB Setup with Jmeter" enabled="false">
        <stringProp name="TestPlan.comments">Note: the link mentioned is only for reference and it is now owned or controlled by Microsoft - https://www.perfmatrix.com/jmeter-grafana-dashboard-using-influxdb/</stringProp>
        <stringProp name="ThreadGroup.num_threads">1</stringProp>
        <stringProp name="ThreadGroup.ramp_time">1</stringProp>
        <boolProp name="ThreadGroup.same_user_on_next_iteration">true</boolProp>
        <stringProp name="ThreadGroup.on_sample_error">continue</stringProp>
        <elementProp name="ThreadGroup.main_controller" elementType="LoopController" guiclass="LoopControlPanel" testclass="LoopController" testname="Loop Controller" enabled="true">
          <boolProp name="LoopController.continue_forever">false</boolProp>
          <stringProp name="LoopController.loops">1</stringProp>
        </elementProp>
        <boolProp name="ThreadGroup.scheduler">false</boolProp>
        <stringProp name="ThreadGroup.duration"></stringProp>
        <stringProp name="ThreadGroup.delay"></stringProp>
      </ThreadGroup>
      <hashTree>
        <HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="Dummy HTTP Sampler" enabled="true">
          <elementProp name="HTTPsampler.Arguments" elementType="Arguments" guiclass="HTTPArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
            <collectionProp name="Arguments.arguments"/>
          </elementProp>
          <stringProp name="HTTPSampler.domain"></stringProp>
          <stringProp name="HTTPSampler.port"></stringProp>
          <stringProp name="HTTPSampler.protocol"></stringProp>
          <stringProp name="HTTPSampler.contentEncoding"></stringProp>
          <stringProp name="HTTPSampler.path">/search?q=Cars</stringProp>
          <stringProp name="HTTPSampler.method">GET</stringProp>
          <boolProp name="HTTPSampler.follow_redirects">true</boolProp>
          <boolProp name="HTTPSampler.auto_redirects">false</boolProp>
          <boolProp name="HTTPSampler.use_keepalive">true</boolProp>
          <boolProp name="HTTPSampler.DO_MULTIPART_POST">false</boolProp>
          <stringProp name="HTTPSampler.embedded_url_re"></stringProp>
          <stringProp name="HTTPSampler.connect_timeout"></stringProp>
          <stringProp name="HTTPSampler.response_timeout"></stringProp>
          <stringProp name="TestPlan.comments">Update the protocol , Basepath and Resource Path</stringProp>
        </HTTPSamplerProxy>
        <hashTree/>
        <BackendListener guiclass="BackendListenerGui" testclass="BackendListener" testname="Backend Listener" enabled="true">
          <elementProp name="arguments" elementType="Arguments" guiclass="ArgumentsPanel" testclass="Arguments" enabled="true">
            <collectionProp name="Arguments.arguments">
              <elementProp name="influxdbMetricsSender" elementType="Argument">
                <stringProp name="Argument.name">influxdbMetricsSender</stringProp>
                <stringProp name="Argument.value">org.apache.jmeter.visualizers.backend.influxdb.HttpMetricsSender</stringProp>
                <stringProp name="Argument.metadata">=</stringProp>
              </elementProp>
              <elementProp name="influxdbUrl" elementType="Argument">
                <stringProp name="Argument.name">influxdbUrl</stringProp>
                <stringProp name="Argument.value">${influxdburl}</stringProp>
                <stringProp name="Argument.metadata">=</stringProp>
              </elementProp>
              <elementProp name="application" elementType="Argument">
                <stringProp name="Argument.name">application</stringProp>
                <stringProp name="Argument.value">application name</stringProp>
                <stringProp name="Argument.metadata">=</stringProp>
              </elementProp>
              <elementProp name="measurement" elementType="Argument">
                <stringProp name="Argument.name">measurement</stringProp>
                <stringProp name="Argument.value">jmeter</stringProp>
                <stringProp name="Argument.metadata">=</stringProp>
              </elementProp>
              <elementProp name="summaryOnly" elementType="Argument">
                <stringProp name="Argument.name">summaryOnly</stringProp>
                <stringProp name="Argument.value">false</stringProp>
                <stringProp name="Argument.metadata">=</stringProp>
              </elementProp>
              <elementProp name="samplersRegex" elementType="Argument">
                <stringProp name="Argument.name">samplersRegex</stringProp>
                <stringProp name="Argument.value">.*</stringProp>
                <stringProp name="Argument.metadata">=</stringProp>
              </elementProp>
              <elementProp name="percentiles" elementType="Argument">
                <stringProp name="Argument.name">percentiles</stringProp>
                <stringProp name="Argument.value">99;95;90</stringProp>
                <stringProp name="Argument.metadata">=</stringProp>
              </elementProp>
              <elementProp name="testTitle" elementType="Argument">
                <stringProp name="Argument.name">testTitle</stringProp>
                <stringProp name="Argument.value">Test name</stringProp>
                <stringProp name="Argument.metadata">=</stringProp>
              </elementProp>
              <elementProp name="eventTags" elementType="Argument">
                <stringProp name="Argument.name">eventTags</stringProp>
                <stringProp name="Argument.value"></stringProp>
                <stringProp name="Argument.metadata">=</stringProp>
              </elementProp>
            </collectionProp>
          </elementProp>
          <stringProp name="classname">org.apache.jmeter.visualizers.backend.influxdb.InfluxdbBackendListenerClient</stringProp>
        </BackendListener>
        <hashTree/>
      </hashTree>
      <ThreadGroup guiclass="ThreadGroupGui" testclass="ThreadGroup" testname="Thread Group - Jmeter to Application Insight " enabled="false">
        <stringProp name="TestPlan.comments">Reference - https://techcommunity.microsoft.com/t5/azure-global/send-your-jmeter-test-results-to-azure-application-insights/ba-p/1195320</stringProp>
        <stringProp name="ThreadGroup.num_threads">1</stringProp>
        <stringProp name="ThreadGroup.ramp_time">1</stringProp>
        <boolProp name="ThreadGroup.same_user_on_next_iteration">true</boolProp>
        <stringProp name="ThreadGroup.on_sample_error">continue</stringProp>
        <elementProp name="ThreadGroup.main_controller" elementType="LoopController" guiclass="LoopControlPanel" testclass="LoopController" testname="Loop Controller" enabled="true">
          <boolProp name="LoopController.continue_forever">false</boolProp>
          <stringProp name="LoopController.loops">1</stringProp>
        </elementProp>
        <boolProp name="ThreadGroup.scheduler">false</boolProp>
        <stringProp name="ThreadGroup.duration"></stringProp>
        <stringProp name="ThreadGroup.delay"></stringProp>
      </ThreadGroup>
      <hashTree>
        <HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="Dummy HTTP Sampler" enabled="true">
          <elementProp name="HTTPsampler.Arguments" elementType="Arguments" guiclass="HTTPArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
            <collectionProp name="Arguments.arguments"/>
          </elementProp>
          <stringProp name="HTTPSampler.domain"></stringProp>
          <stringProp name="HTTPSampler.port"></stringProp>
          <stringProp name="HTTPSampler.protocol"></stringProp>
          <stringProp name="HTTPSampler.contentEncoding"></stringProp>
          <stringProp name="HTTPSampler.path">/search?q=jmeter</stringProp>
          <stringProp name="HTTPSampler.method">GET</stringProp>
          <boolProp name="HTTPSampler.follow_redirects">true</boolProp>
          <boolProp name="HTTPSampler.auto_redirects">false</boolProp>
          <boolProp name="HTTPSampler.use_keepalive">true</boolProp>
          <boolProp name="HTTPSampler.DO_MULTIPART_POST">false</boolProp>
          <stringProp name="HTTPSampler.embedded_url_re"></stringProp>
          <stringProp name="HTTPSampler.connect_timeout"></stringProp>
          <stringProp name="HTTPSampler.response_timeout"></stringProp>
          <stringProp name="TestPlan.comments">Update the protocol , Basepath and Resource Path</stringProp>
        </HTTPSamplerProxy>
        <hashTree/>
        <BackendListener guiclass="BackendListenerGui" testclass="BackendListener" testname="Backend Listener" enabled="true">
          <elementProp name="arguments" elementType="Arguments" guiclass="ArgumentsPanel" testclass="Arguments" enabled="true">
            <collectionProp name="Arguments.arguments">
              <elementProp name="testName" elementType="Argument">
                <stringProp name="Argument.name">testName</stringProp>
                <stringProp name="Argument.value">jmeter</stringProp>
                <stringProp name="Argument.metadata">=</stringProp>
              </elementProp>
              <elementProp name="connectionString" elementType="Argument">
                <stringProp name="Argument.name">connectionString</stringProp>
                <stringProp name="Argument.value">${appinsightconnectionstring}</stringProp>
                <stringProp name="Argument.metadata">=</stringProp>
              </elementProp>
              <elementProp name="liveMetrics" elementType="Argument">
                <stringProp name="Argument.name">liveMetrics</stringProp>
                <stringProp name="Argument.value">true</stringProp>
                <stringProp name="Argument.metadata">=</stringProp>
              </elementProp>
              <elementProp name="samplersList" elementType="Argument">
                <stringProp name="Argument.name">samplersList</stringProp>
                <stringProp name="Argument.value"></stringProp>
                <stringProp name="Argument.metadata">=</stringProp>
              </elementProp>
              <elementProp name="useRegexForSamplerList" elementType="Argument">
                <stringProp name="Argument.name">useRegexForSamplerList</stringProp>
                <stringProp name="Argument.value">false</stringProp>
                <stringProp name="Argument.metadata">=</stringProp>
              </elementProp>
              <elementProp name="logResponseData" elementType="Argument">
                <stringProp name="Argument.name">logResponseData</stringProp>
                <stringProp name="Argument.value">OnFailure</stringProp>
                <stringProp name="Argument.metadata">=</stringProp>
              </elementProp>
              <elementProp name="logSampleData" elementType="Argument">
                <stringProp name="Argument.name">logSampleData</stringProp>
                <stringProp name="Argument.value">OnFailure</stringProp>
                <stringProp name="Argument.metadata">=</stringProp>
              </elementProp>
            </collectionProp>
          </elementProp>
          <stringProp name="classname">io.github.adrianmo.jmeter.backendlistener.azure.AzureBackendClient</stringProp>
        </BackendListener>
        <hashTree/>
      </hashTree>
      <ThreadGroup guiclass="ThreadGroupGui" testclass="ThreadGroup" testname="Thread Group - Jmeter for DataBricks Job Test" enabled="false">
        <stringProp name="ThreadGroup.num_threads">1</stringProp>
        <stringProp name="ThreadGroup.ramp_time">1</stringProp>
        <boolProp name="ThreadGroup.same_user_on_next_iteration">true</boolProp>
        <stringProp name="ThreadGroup.on_sample_error">continue</stringProp>
        <elementProp name="ThreadGroup.main_controller" elementType="LoopController" guiclass="LoopControlPanel" testclass="LoopController" testname="Loop Controller" enabled="true">
          <boolProp name="LoopController.continue_forever">false</boolProp>
          <stringProp name="LoopController.loops">1</stringProp>
        </elementProp>
        <boolProp name="ThreadGroup.scheduler">false</boolProp>
        <stringProp name="ThreadGroup.duration"></stringProp>
        <stringProp name="ThreadGroup.delay"></stringProp>
      </ThreadGroup>
      <hashTree>
        <CSVDataSet guiclass="TestBeanGUI" testclass="CSVDataSet" testname="CSV Data Set Config" enabled="true">
          <stringProp name="TestPlan.comments">this data will be used by Databricks job</stringProp>
          <stringProp name="filename">sourcedestinationtable.csv</stringProp>
          <stringProp name="fileEncoding">UTF-8</stringProp>
          <stringProp name="variableNames">sourcedbname,sourcetablename,datamartloadingbehaviour,primarykey,datamarkscheme,DatamartTablename, SourceSystem,DatabaseType</stringProp>
          <boolProp name="ignoreFirstLine">false</boolProp>
          <stringProp name="delimiter">,</stringProp>
          <boolProp name="quotedData">false</boolProp>
          <boolProp name="recycle">true</boolProp>
          <boolProp name="stopThread">false</boolProp>
          <stringProp name="shareMode">shareMode.all</stringProp>
        </CSVDataSet>
        <hashTree/>
        <HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="DataBricks Job Trigger" enabled="true">
          <boolProp name="HTTPSampler.postBodyRaw">true</boolProp>
          <elementProp name="HTTPsampler.Arguments" elementType="Arguments">
            <collectionProp name="Arguments.arguments">
              <elementProp name="" elementType="HTTPArgument">
                <boolProp name="HTTPArgument.always_encode">false</boolProp>
                <stringProp name="Argument.value">{&#xd;
	&quot;job_id&quot;:&quot;${databricksjobid}&quot;,&#xd;
	&quot;notebook_params&quot;:{&#xd;
//		the below Key Value pair can be seen in the ADF pipeline where Databricks job is called &#xd;
// 		you have to enter all the key value pair and use the existing job Id in this to invoke the job&#xd;
//		Also in Databrick console app - increase the concurrency so that when you hit more than 1 HTTP sampler &#xd;
		&quot;source_db_name&quot;:&quot;&quot;,&#xd;
		&quot;pipeline_name&quot;:&quot;samplepipelinename&quot;,&#xd;
		&quot;source_table_name&quot;:&quot;&quot;,&#xd;
		&quot;db_loadingbehaviour&quot;:&quot;&quot;,&#xd;
		&quot;sourcetype&quot;:&quot;&quot;,&#xd;
		&quot;adf_run_id&quot;:&quot;&quot;,&#xd;
		....&#xd;
	}&#xd;
}</stringProp>
                <stringProp name="Argument.metadata">=</stringProp>
              </elementProp>
            </collectionProp>
          </elementProp>
          <stringProp name="HTTPSampler.domain"></stringProp>
          <stringProp name="HTTPSampler.port"></stringProp>
          <stringProp name="HTTPSampler.protocol"></stringProp>
          <stringProp name="HTTPSampler.contentEncoding"></stringProp>
          <stringProp name="HTTPSampler.path">/api/2.0/jobs/run-now</stringProp>
          <stringProp name="HTTPSampler.method">POST</stringProp>
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
              <elementProp name="" elementType="Header">
                <stringProp name="Header.name">token</stringProp>
                <stringProp name="Header.value">databrick_autorizationtoken</stringProp>
              </elementProp>
            </collectionProp>
          </HeaderManager>
          <hashTree/>
          <JSONPostProcessor guiclass="JSONPostProcessorGui" testclass="JSONPostProcessor" testname="JSON Extractor" enabled="true">
            <stringProp name="JSONPostProcessor.referenceNames">response</stringProp>
            <stringProp name="JSONPostProcessor.jsonPathExprs">status:(+d),</stringProp>
            <stringProp name="JSONPostProcessor.match_numbers"></stringProp>
          </JSONPostProcessor>
          <hashTree/>
        </hashTree>
        <WhileController guiclass="WhileControllerGui" testclass="WhileController" testname="While Controller" enabled="true">
          <stringProp name="WhileController.condition">$'{__jexl3($'{__P(response)}!=&quot;success&quot;)}</stringProp>
        </WhileController>
        <hashTree>
          <HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="DataBricks Job Trigger" enabled="true">
            <boolProp name="HTTPSampler.postBodyRaw">true</boolProp>
            <elementProp name="HTTPsampler.Arguments" elementType="Arguments">
              <collectionProp name="Arguments.arguments">
                <elementProp name="" elementType="HTTPArgument">
                  <boolProp name="HTTPArgument.always_encode">false</boolProp>
                  <stringProp name="Argument.value">{&#xd;
	&quot;job_id&quot;:,&#xd;
	&quot;notebook_params&quot;:{&#xd;
//		the below Key Value pair can be seen in the ADF pipeline where Databricks job is called &#xd;
// 		you have to enter all the key value pair and use the existing job Id in this to invoke the job&#xd;
//		Also in Databrick console app - increase the concurrency so that when you hit more than 1 HTTP sampler &#xd;
		&quot;source_db_name&quot;:&quot;&quot;,&#xd;
		&quot;pipeline_name&quot;:&quot;samplepipelinename&quot;,&#xd;
		&quot;source_table_name&quot;:&quot;&quot;,&#xd;
		&quot;db_loadingbehaviour&quot;:&quot;&quot;,&#xd;
		&quot;sourcetype&quot;:&quot;&quot;,&#xd;
		&quot;adf_run_id&quot;:&quot;&quot;,&#xd;
		....&#xd;
	}&#xd;
}</stringProp>
                  <stringProp name="Argument.metadata">=</stringProp>
                </elementProp>
              </collectionProp>
            </elementProp>
            <stringProp name="HTTPSampler.domain"></stringProp>
            <stringProp name="HTTPSampler.port"></stringProp>
            <stringProp name="HTTPSampler.protocol">${protocol}</stringProp>
            <stringProp name="HTTPSampler.contentEncoding"></stringProp>
            <stringProp name="HTTPSampler.path">/api/2.0/jobs/run-now</stringProp>
            <stringProp name="HTTPSampler.method">POST</stringProp>
            <boolProp name="HTTPSampler.follow_redirects">true</boolProp>
            <boolProp name="HTTPSampler.auto_redirects">false</boolProp>
            <boolProp name="HTTPSampler.use_keepalive">true</boolProp>
            <boolProp name="HTTPSampler.DO_MULTIPART_POST">false</boolProp>
            <stringProp name="HTTPSampler.embedded_url_re"></stringProp>
            <stringProp name="HTTPSampler.connect_timeout"></stringProp>
            <stringProp name="HTTPSampler.response_timeout"></stringProp>
          </HTTPSamplerProxy>
          <hashTree>
            <JSONPostProcessor guiclass="JSONPostProcessorGui" testclass="JSONPostProcessor" testname="JSON Extractor" enabled="true">
              <stringProp name="JSONPostProcessor.referenceNames">response</stringProp>
              <stringProp name="JSONPostProcessor.jsonPathExprs">status:(+d),</stringProp>
              <stringProp name="JSONPostProcessor.match_numbers"></stringProp>
            </JSONPostProcessor>
            <hashTree/>
          </hashTree>
          <TestAction guiclass="TestActionGui" testclass="TestAction" testname="Think Time" enabled="true">
            <intProp name="ActionProcessor.action">1</intProp>
            <intProp name="ActionProcessor.target">0</intProp>
            <stringProp name="ActionProcessor.duration">1000</stringProp>
          </TestAction>
          <hashTree/>
        </hashTree>
      </hashTree>
      <ThreadGroup guiclass="ThreadGroupGui" testclass="ThreadGroup" testname="Thread Group - Jmeter Database Testing" enabled="false">
        <stringProp name="TestPlan.comments">For Reference - https://youtu.be/Rhh-YBY9jUo?si=ZweimYGs7jPmOh0B</stringProp>
        <stringProp name="ThreadGroup.num_threads">1</stringProp>
        <stringProp name="ThreadGroup.ramp_time">1</stringProp>
        <boolProp name="ThreadGroup.same_user_on_next_iteration">true</boolProp>
        <stringProp name="ThreadGroup.on_sample_error">continue</stringProp>
        <elementProp name="ThreadGroup.main_controller" elementType="LoopController" guiclass="LoopControlPanel" testclass="LoopController" testname="Loop Controller" enabled="true">
          <boolProp name="LoopController.continue_forever">false</boolProp>
          <stringProp name="LoopController.loops">1</stringProp>
        </elementProp>
        <boolProp name="ThreadGroup.scheduler">false</boolProp>
        <stringProp name="ThreadGroup.duration"></stringProp>
        <stringProp name="ThreadGroup.delay"></stringProp>
      </ThreadGroup>
      <hashTree>
        <JDBCDataSource guiclass="TestBeanGUI" testclass="JDBCDataSource" testname="JDBC Connection Configuration" enabled="true">
          <boolProp name="autocommit">true</boolProp>
          <stringProp name="checkQuery"></stringProp>
          <stringProp name="connectionAge">5000</stringProp>
          <stringProp name="connectionProperties"></stringProp>
          <stringProp name="dataSource">dbconnectionstring</stringProp>
          <stringProp name="dbUrl"></stringProp>
          <stringProp name="driver"></stringProp>
          <stringProp name="initQuery"></stringProp>
          <boolProp name="keepAlive">true</boolProp>
          <stringProp name="password"></stringProp>
          <stringProp name="poolMax">1</stringProp>
          <boolProp name="preinit">false</boolProp>
          <stringProp name="timeout">10000</stringProp>
          <stringProp name="transactionIsolation">DEFAULT</stringProp>
          <stringProp name="trimInterval">60000</stringProp>
          <stringProp name="username"></stringProp>
        </JDBCDataSource>
        <hashTree/>
        <JDBCSampler guiclass="TestBeanGUI" testclass="JDBCSampler" testname="JDBC Request" enabled="true">
          <stringProp name="dataSource">dbconnectionstring</stringProp>
          <stringProp name="query">select * from user</stringProp>
          <stringProp name="queryArguments"></stringProp>
          <stringProp name="queryArgumentsTypes"></stringProp>
          <stringProp name="queryTimeout"></stringProp>
          <stringProp name="queryType">Select Statement</stringProp>
          <stringProp name="resultSetHandler">Store as String</stringProp>
          <stringProp name="resultSetMaxRows"></stringProp>
          <stringProp name="resultVariable"></stringProp>
          <stringProp name="variableNames"></stringProp>
        </JDBCSampler>
        <hashTree/>
      </hashTree>
      <ThreadGroup guiclass="ThreadGroupGui" testclass="ThreadGroup" testname="Thread Group - Jmeter UI Performance Test" enabled="false">
        <stringProp name="TestPlan.comments">Note- Some of the feature like wait are not working smoothly with latest java but working fine with jdk1.8</stringProp>
        <stringProp name="ThreadGroup.num_threads">1</stringProp>
        <stringProp name="ThreadGroup.ramp_time">1</stringProp>
        <boolProp name="ThreadGroup.same_user_on_next_iteration">true</boolProp>
        <stringProp name="ThreadGroup.on_sample_error">continue</stringProp>
        <elementProp name="ThreadGroup.main_controller" elementType="LoopController" guiclass="LoopControlPanel" testclass="LoopController" testname="Loop Controller" enabled="true">
          <boolProp name="LoopController.continue_forever">false</boolProp>
          <stringProp name="LoopController.loops">1</stringProp>
        </elementProp>
        <boolProp name="ThreadGroup.scheduler">false</boolProp>
        <stringProp name="ThreadGroup.duration"></stringProp>
        <stringProp name="ThreadGroup.delay"></stringProp>
      </ThreadGroup>
      <hashTree>
        <IfController guiclass="IfControllerPanel" testclass="IfController" testname="Cookies Generator" enabled="true">
          <stringProp name="IfController.condition"></stringProp>
          <boolProp name="IfController.evaluateAll">false</boolProp>
          <boolProp name="IfController.useExpression">true</boolProp>
          <stringProp name="TestPlan.comments">If app login can be bapassed using cookies - You can generate the cookies and use them for further page hits.</stringProp>
        </IfController>
        <hashTree>
          <com.googlecode.jmeter.plugins.webdriver.config.ChromeDriverConfig guiclass="com.googlecode.jmeter.plugins.webdriver.config.gui.ChromeDriverConfigGui" testclass="com.googlecode.jmeter.plugins.webdriver.config.ChromeDriverConfig" testname="Chrome Driver Initialization" enabled="true">
            <stringProp name="WebDriverConfig.proxy_type">SYSTEM</stringProp>
            <stringProp name="WebDriverConfig.proxy_pac_url"></stringProp>
            <stringProp name="WebDriverConfig.http_host"></stringProp>
            <intProp name="WebDriverConfig.http_port">8080</intProp>
            <boolProp name="WebDriverConfig.use_http_for_all_protocols">true</boolProp>
            <stringProp name="WebDriverConfig.https_host"></stringProp>
            <intProp name="WebDriverConfig.https_port">8080</intProp>
            <stringProp name="WebDriverConfig.ftp_host"></stringProp>
            <intProp name="WebDriverConfig.ftp_port">8080</intProp>
            <stringProp name="WebDriverConfig.socks_host"></stringProp>
            <intProp name="WebDriverConfig.socks_port">8080</intProp>
            <stringProp name="WebDriverConfig.no_proxy">localhost</stringProp>
            <boolProp name="WebDriverConfig.maximize_browser">true</boolProp>
            <boolProp name="WebDriverConfig.reset_per_iteration">false</boolProp>
            <boolProp name="WebDriverConfig.dev_mode">false</boolProp>
            <stringProp name="ChromeDriverConfig.chromedriver_path"></stringProp>
            <boolProp name="ChromeDriverConfig.android_enabled">false</boolProp>
            <boolProp name="ChromeDriverConfig.headless_enabled">true</boolProp>
            <boolProp name="ChromeDriverConfig.insecurecerts_enabled">true</boolProp>
            <boolProp name="ChromeDriverConfig.incognito_enabled">true</boolProp>
            <boolProp name="ChromeDriverConfig.no_sandbox_enabled">false</boolProp>
            <boolProp name="WebDriverConfig.acceptinsecurecerts">false</boolProp>
            <stringProp name="WebDriverConfig.driver_path"></stringProp>
            <boolProp name="WebDriverConfig.headless">false</boolProp>
            <stringProp name="ChromeDriverConfig.additional_args"></stringProp>
            <stringProp name="ChromeDriverConfig.binary_path"></stringProp>
            <stringProp name="WebDriverConfig.custom_capabilites"></stringProp>
          </com.googlecode.jmeter.plugins.webdriver.config.ChromeDriverConfig>
          <hashTree/>
          <com.googlecode.jmeter.plugins.webdriver.sampler.WebDriverSampler guiclass="com.googlecode.jmeter.plugins.webdriver.sampler.gui.WebDriverSamplerGui" testclass="com.googlecode.jmeter.plugins.webdriver.sampler.WebDriverSampler" testname="Login to portal" enabled="true">
            <stringProp name="WebDriverSampler.script">WDS.sampleResult.sampleStart()
var vars = org.apache.jmeter.threads.JMeterContextService.getContext().getVariables()
var pkg = JavaImporter(org.openqa.selenium)
var support_ui = JavaImporter(org.openqa.selenium.support.ui.WebDriverWait)
var ui = JavaImporter(org.openqa.selenium.support.ui)
var wait = new support_ui.WebDriverWait(WDS.browser, 50)
var waitless = new support_ui.WebDriverWait(WDS.browser, 10)
var wait_sec = new support_ui.WebDriverWait(WDS.browser, 1)
var hosturl = &apos;https://&apos;+WDS.args[0];
var emailid = WDS.args[1];
var password = WDS.args[2];
var username_xpath = WDS.args[3];
var submit_xpath = WDS.args[4];
var redirectlink_xpath = WDS.args[5];
var formauthentication_xpath = WDS.args[6];
var password_xpath = WDS.args[7];
var submitbutton_xpath = WDS.args[8];
var passwordinput_xpath = WDS.args[9];

WDS.browser.get(hosturl);
if(WDS.browser.getTitle() == &apos;Service unavailable&apos;) {
    WDS.log.info(&quot;Retry Again&quot;);
    WDS.browser.get(hosturl)
}
var flag = 1;
if(WDS.browser.getTitle() == &apos;NBA - Mission Control&apos;) {
   WDS.log.info(&quot;Retry Again&quot;);
   WDS.browser.get(hosturl);
}

/**
 * Login - Check
 */
if(emailid.contains(&apos;validemailid&apos;)) {
	try {
	var username = wait.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath()));
		username.sendKeys([emailid]);
		var submit = wait.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath()));
		submit.click();
			
		var passwordele = wait.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath(&quot;//*[@id=\&quot;passwordInput\&quot;]&quot;)));	
		passwordele.sendKeys([password]);
		var submit = wait.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath(&quot;//*[@id=\&quot;submitButton\&quot;]&quot;)));
		submit.click();
	
		var submitform = wait.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath()))
		submitform.click();
	}	
	catch(err)
	{
	 	WDS.log.info(&quot;Login Retry Failure&quot;+err); 
	}	
}
else
{ 
	try {
		var username = wait.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath()))
		username.sendKeys([emailid]);
		var submit = wait.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath()))
		submit.click();
		
		// Handle use password instead popup //
		try {
			var popup = waitless.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath(&quot;//*[@id=\&quot;idA_PWD_SwitchToCredPicker\&quot;]&quot;)));	
			popup.click();
			
			var popup2 = waitless.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath(&quot;//*[@id=\&quot;credentialList\&quot;]/div[2]/div/div/div[2]/div&quot;)));	 
			popup2.click();	
			
			var redirectlink = wait.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath()))
			redirectlink.click();
		}catch(err)
		{
			WDS.log.info(&quot;Redirect not shown&quot;);
		}
	
		// Fill Password//
		var passwordform = waitless.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath()))
		passwordform.click();
		var passwordinput = waitless.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath()))
		passwordinput.sendKeys([password]);
		submit = waitless.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath()))
		submit.click();
	
		// Handle Remember User Yes / Non popup //
		var confirmationpopup = wait.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath()))
		confirmationpopup.click();
	}
	catch(err)
	{	 
	}
}

WDS.sampleResult.sampleEnd();
WDS.log.info(&quot;Login Successfull&quot;);</stringProp>
            <stringProp name="WebDriverSampler.parameters">System.Management.Automation.Internal.Host.InternalHost         </stringProp>
            <stringProp name="WebDriverSampler.language">groovy</stringProp>
          </com.googlecode.jmeter.plugins.webdriver.sampler.WebDriverSampler>
          <hashTree/>
          <com.googlecode.jmeter.plugins.webdriver.sampler.WebDriverSampler guiclass="com.googlecode.jmeter.plugins.webdriver.sampler.gui.WebDriverSamplerGui" testclass="com.googlecode.jmeter.plugins.webdriver.sampler.WebDriverSampler" testname="Login to portal - Retry" enabled="true">
            <stringProp name="WebDriverSampler.script">WDS.sampleResult.sampleStart()
var vars = org.apache.jmeter.threads.JMeterContextService.getContext().getVariables()
var pkg = JavaImporter(org.openqa.selenium)
var support_ui = JavaImporter(org.openqa.selenium.support.ui.WebDriverWait)
var ui = JavaImporter(org.openqa.selenium.support.ui)
var wait = new support_ui.WebDriverWait(WDS.browser, 50)
var waitless = new support_ui.WebDriverWait(WDS.browser, 10)
var wait_sec = new support_ui.WebDriverWait(WDS.browser, 1)
var hosturl = &apos;https://&apos;+WDS.args[0];
var emailid = WDS.args[1];
var password = WDS.args[2];
var username_xpath = WDS.args[3];
var submit_xpath = WDS.args[4];
var redirectlink_xpath = WDS.args[5];
var formauthentication_xpath = WDS.args[6];
var password_xpath = WDS.args[7];
var submitbutton_xpath = WDS.args[8];
var passwordinput_xpath = WDS.args[9];


if(WDS.browser.getTitle() == &apos;sampletitle&apos;) {
 WDS.log.info(&quot;******* Retry not Needed *******&quot;);  
}

else
{ 
	WDS.log.info(&quot;******* Retry Again *******&quot;);  
	WDS.browser.get(hosturl);
	java.lang.Thread.sleep(10000);

	/**
	 * Login - Check
	 */
	if(emailid.contains(&apos;sampleemailid&apos;)) {
		try {
		var username = wait.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath()));
			username.sendKeys([emailid]);
			var submit = wait.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath()));
			submit.click();
				
			var passwordele = wait.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath(&quot;//*[@id=\&quot;passwordInput\&quot;]&quot;)));	
			passwordele.sendKeys([password]);
			var submit = wait.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath(&quot;//*[@id=\&quot;submitButton\&quot;]&quot;)));
			submit.click();
		
			var submitform = wait.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath()))
			submitform.click();
		}	
		catch(err)
		{
		 	WDS.log.info(&quot;Login Retry Failure&quot;+err); 
		}	
	}
	else
	{ 
		try {
			var username = wait.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath()))
			username.sendKeys([emailid]);
			var submit = wait.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath()))
			submit.click();
			
			// Handle use password instead popup //
			try {
				var popup = waitless.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath(&quot;//*[@id=\&quot;idA_PWD_SwitchToCredPicker\&quot;]&quot;)));	
				popup.click();
				
				var popup2 = waitless.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath(&quot;//*[@id=\&quot;credentialList\&quot;]/div[2]/div/div/div[2]/div&quot;)));	 
				popup2.click();	
				
				var redirectlink = wait.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath()))
				redirectlink.click();
			}catch(err)
			{
				WDS.log.info(&quot;Redirect not shown&quot;);
			}
		
			// Fill Password//
			var passwordform = waitless.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath()))
			passwordform.click();
			var passwordinput = waitless.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath()))
			passwordinput.sendKeys([password]);
			submit = waitless.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath()))
			submit.click();
		
			// Handle Remember User Yes / Non popup //
			var confirmationpopup = wait.until(ui.ExpectedConditions.visibilityOfElementLocated(pkg.By.xpath()))
			confirmationpopup.click();
		}
		catch(err)
		{	 
		}
	}	
}
WDS.sampleResult.sampleEnd();</stringProp>
            <stringProp name="WebDriverSampler.parameters">System.Management.Automation.Internal.Host.InternalHost         </stringProp>
            <stringProp name="WebDriverSampler.language">groovy</stringProp>
          </com.googlecode.jmeter.plugins.webdriver.sampler.WebDriverSampler>
          <hashTree/>
          <com.googlecode.jmeter.plugins.webdriver.sampler.WebDriverSampler guiclass="com.googlecode.jmeter.plugins.webdriver.sampler.gui.WebDriverSamplerGui" testclass="com.googlecode.jmeter.plugins.webdriver.sampler.WebDriverSampler" testname="Get Cookies and close browser" enabled="true">
            <stringProp name="WebDriverSampler.script">WDS.sampleResult.sampleStart()
var vars = org.apache.jmeter.threads.JMeterContextService.getContext().getVariables()
var pkg = JavaImporter(org.openqa.selenium)
var support_ui = JavaImporter(org.openqa.selenium.support.ui.WebDriverWait)
var ui = JavaImporter(org.openqa.selenium.support.ui)
var wait = new support_ui.WebDriverWait(WDS.browser, 15)
var wait_sec = new support_ui.WebDriverWait(WDS.browser, 1)
var host = WDS.args[0];
var livegameurl = WDS.args[1];
var hosturl = &apos;https://&apos;+ host + livegameurl;
 
WDS.log.info(&quot;**** Get Cookies **** &quot;);
try {
WDS.browser.get(hosturl)
/**
 * Checking for Title
 */
if(WDS.browser.getTitle() != &apos;SampleTitle&apos;) {
    WDS.log.info(&quot;Retry Again&quot;);
    WDS.browser.get(hosturl);
}

var cookies = WDS.browser.manage().getCookies();

WDS.log.info(&apos;Cookies = &apos; + cookies);

WDS.sampleResult.sampleEnd();
WDS.log.info(&quot;Successfully navigated to Live Game Page&quot;);

} catch(err)
{
	WDS.log.info(&quot;Issue&quot;);
}


vars.put(&quot;cookies&quot;,cookies.toString());
WDS.sampleResult.setSuccessful(true);
WDS.browser.close();</stringProp>
            <stringProp name="WebDriverSampler.parameters">System.Management.Automation.Internal.Host.InternalHost </stringProp>
            <stringProp name="WebDriverSampler.language">groovy</stringProp>
          </com.googlecode.jmeter.plugins.webdriver.sampler.WebDriverSampler>
          <hashTree/>
          <JSR223Sampler guiclass="TestBeanGUI" testclass="JSR223Sampler" testname="Assign Cookies - Setup ThreadGroup" enabled="true">
            <stringProp name="scriptLanguage">groovy</stringProp>
            <stringProp name="parameters"></stringProp>
            <stringProp name="filename"></stringProp>
            <stringProp name="cacheKey">true</stringProp>
            <stringProp name="script">String cookiescleaner = &quot;&quot;;
cookiescleaner = cookiescleaner.replace(&quot;[&quot;,&quot;&quot;).replace(&quot;]&quot;,&quot;&quot;);
props.put(&quot;cookies&quot;,cookiescleaner);
//log.info(&quot;Cookies is assigned and ready to get used&quot;,+cookies);</stringProp>
          </JSR223Sampler>
          <hashTree/>
        </hashTree>
        <CacheManager guiclass="CacheManagerGui" testclass="CacheManager" testname="HTTP Cache Manager" enabled="true">
          <boolProp name="clearEachIteration">true</boolProp>
          <boolProp name="useExpires">false</boolProp>
          <boolProp name="CacheManager.controlledByThread">false</boolProp>
        </CacheManager>
        <hashTree/>
        <com.googlecode.jmeter.plugins.webdriver.config.HtmlUnitDriverConfig guiclass="com.googlecode.jmeter.plugins.webdriver.config.gui.HtmlUnitDriverConfigGui" testclass="com.googlecode.jmeter.plugins.webdriver.config.HtmlUnitDriverConfig" testname="jp@gc - HtmlUnit Driver Config" enabled="true">
          <boolProp name="WebDriverConfig.acceptinsecurecerts">false</boolProp>
          <boolProp name="WebDriverConfig.reset_per_iteration">true</boolProp>
          <stringProp name="WebDriverConfig.proxy_type">SYSTEM</stringProp>
          <stringProp name="WebDriverConfig.proxy_pac_url"></stringProp>
          <stringProp name="WebDriverConfig.http_host"></stringProp>
          <intProp name="WebDriverConfig.http_port">8080</intProp>
          <boolProp name="WebDriverConfig.use_http_for_all_protocols">true</boolProp>
          <stringProp name="WebDriverConfig.https_host"></stringProp>
          <intProp name="WebDriverConfig.https_port">8080</intProp>
          <stringProp name="WebDriverConfig.ftp_host"></stringProp>
          <intProp name="WebDriverConfig.ftp_port">8080</intProp>
          <stringProp name="WebDriverConfig.socks_host"></stringProp>
          <intProp name="WebDriverConfig.socks_port">8080</intProp>
          <stringProp name="WebDriverConfig.no_proxy">localhost</stringProp>
          <stringProp name="WebDriverConfig.custom_capabilites"></stringProp>
          <stringProp name="TestPlan.comments">This is headless can be used straightly for Page hits.</stringProp>
        </com.googlecode.jmeter.plugins.webdriver.config.HtmlUnitDriverConfig>
        <hashTree/>
        <com.googlecode.jmeter.plugins.webdriver.config.ChromeDriverConfig guiclass="com.googlecode.jmeter.plugins.webdriver.config.gui.ChromeDriverConfigGui" testclass="com.googlecode.jmeter.plugins.webdriver.config.ChromeDriverConfig" testname="jp@gc - Chrome Driver Config" enabled="true">
          <boolProp name="WebDriverConfig.acceptinsecurecerts">false</boolProp>
          <boolProp name="WebDriverConfig.reset_per_iteration">false</boolProp>
          <stringProp name="WebDriverConfig.driver_path"></stringProp>
          <boolProp name="WebDriverConfig.dev_mode">false</boolProp>
          <boolProp name="WebDriverConfig.headless">false</boolProp>
          <boolProp name="WebDriverConfig.maximize_browser">true</boolProp>
          <stringProp name="ChromeDriverConfig.additional_args"></stringProp>
          <stringProp name="ChromeDriverConfig.binary_path"></stringProp>
          <stringProp name="WebDriverConfig.proxy_type">SYSTEM</stringProp>
          <stringProp name="WebDriverConfig.proxy_pac_url"></stringProp>
          <stringProp name="WebDriverConfig.http_host"></stringProp>
          <intProp name="WebDriverConfig.http_port">8080</intProp>
          <boolProp name="WebDriverConfig.use_http_for_all_protocols">true</boolProp>
          <stringProp name="WebDriverConfig.https_host"></stringProp>
          <intProp name="WebDriverConfig.https_port">8080</intProp>
          <stringProp name="WebDriverConfig.ftp_host"></stringProp>
          <intProp name="WebDriverConfig.ftp_port">8080</intProp>
          <stringProp name="WebDriverConfig.socks_host"></stringProp>
          <intProp name="WebDriverConfig.socks_port">8080</intProp>
          <stringProp name="WebDriverConfig.no_proxy">localhost</stringProp>
          <stringProp name="WebDriverConfig.custom_capabilites"></stringProp>
        </com.googlecode.jmeter.plugins.webdriver.config.ChromeDriverConfig>
        <hashTree/>
        <JSR223Sampler guiclass="TestBeanGUI" testclass="JSR223Sampler" testname="Start Time" enabled="true">
          <stringProp name="scriptLanguage">groovy</stringProp>
          <stringProp name="parameters"></stringProp>
          <stringProp name="filename"></stringProp>
          <stringProp name="cacheKey">true</stringProp>
          <stringProp name="script">Date latestdate = new Date(); 
Random rnd = new Random();
vars.put(&quot;ArchDef&quot;,Integer.toString(rnd.nextInt(11)+1));
log.info(Integer.toString(rnd.nextInt(11)+1));
Long starttime=latestdate.getTime();
vars.put(&quot;StartTime&quot;,Long.toString(starttime));
log.info(Long.toString(starttime));
</stringProp>
        </JSR223Sampler>
        <hashTree/>
        <com.googlecode.jmeter.plugins.webdriver.sampler.WebDriverSampler guiclass="com.googlecode.jmeter.plugins.webdriver.sampler.gui.WebDriverSamplerGui" testclass="com.googlecode.jmeter.plugins.webdriver.sampler.WebDriverSampler" testname="Searching Cars in Bing Search" enabled="true">
          <stringProp name="WebDriverSampler.script">WDS.sampleResult.sampleStart()
var vars = org.apache.jmeter.threads.JMeterContextService.getContext().getVariables()
var pkg = JavaImporter(org.openqa.selenium)
var support_ui = JavaImporter(org.openqa.selenium.support.ui.WebDriverWait)
var ui = JavaImporter(org.openqa.selenium.support.ui)
var wait = new ui.WebDriverWait(WDS.browser, java.time.Duration.ofSeconds(120))

var baseurl = WDS.args[0];

var hosturl = &quot;https://www.bing.com/search?q=Cars&quot;;
var before = new Date().getTime()
WDS.browser.get(hosturl);
WDS.log.info(hosturl)
try {
	//** Checking Search and About href Title if clickable means page is interactive ** //
//	var searchicon = wait.until(ui.ExpectedConditions.elementToBeClickable(pkg.By.xpath(&quot;//span[@class=\&quot;icon-search\&quot;]&quot;)));
	//wait.until(ui.ExpectedConditions.elementToBeClickable(pkg.By.xpath(&quot;//textarea&quot;)));
}
catch(err)
{
 	WDS.log.info(&quot;Login Retry Failure&quot;+err); 
}
var after = new Date().getTime()
WDS.log.info(&apos;Time taken = &apos; + (after - before) + &apos; ms&apos;);
WDS.sampleResult.sampleEnd();</stringProp>
          <stringProp name="WebDriverSampler.parameters"></stringProp>
          <stringProp name="WebDriverSampler.language">groovy</stringProp>
        </com.googlecode.jmeter.plugins.webdriver.sampler.WebDriverSampler>
        <hashTree>
          <DurationAssertion guiclass="DurationAssertionGui" testclass="DurationAssertion" testname="Duration Assertion" enabled="true">
            <stringProp name="DurationAssertion.duration">3000</stringProp>
          </DurationAssertion>
          <hashTree/>
        </hashTree>
        <ResultCollector guiclass="StatVisualizer" testclass="ResultCollector" testname="Aggregate Report" enabled="true">
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
      <ThreadGroup guiclass="ThreadGroupGui" testclass="ThreadGroup" testname="Thread Group - Dummy Sampler " enabled="false">
        <stringProp name="TestPlan.comments">Case - without using network if we need to debug our script which can reach 30TPS we can configure Dummy Sampler</stringProp>
        <stringProp name="ThreadGroup.num_threads">1</stringProp>
        <stringProp name="ThreadGroup.ramp_time">1</stringProp>
        <boolProp name="ThreadGroup.same_user_on_next_iteration">true</boolProp>
        <stringProp name="ThreadGroup.on_sample_error">continue</stringProp>
        <elementProp name="ThreadGroup.main_controller" elementType="LoopController" guiclass="LoopControlPanel" testclass="LoopController" testname="Loop Controller" enabled="true">
          <boolProp name="LoopController.continue_forever">false</boolProp>
          <stringProp name="LoopController.loops">1</stringProp>
        </elementProp>
        <boolProp name="ThreadGroup.scheduler">false</boolProp>
        <stringProp name="ThreadGroup.duration"></stringProp>
        <stringProp name="ThreadGroup.delay"></stringProp>
      </ThreadGroup>
      <hashTree>
        <kg.apc.jmeter.samplers.DummySampler guiclass="kg.apc.jmeter.samplers.DummySamplerGui" testclass="kg.apc.jmeter.samplers.DummySampler" testname="jp@gc - Dummy Sampler" enabled="true">
          <boolProp name="WAITING">true</boolProp>
          <boolProp name="SUCCESFULL">true</boolProp>
          <stringProp name="RESPONSE_CODE">200</stringProp>
          <stringProp name="RESPONSE_MESSAGE">OK</stringProp>
          <stringProp name="REQUEST_DATA">Dummy Sampler used to simulate requests and responses
without actual network activity. This helps debugging tests.</stringProp>
          <stringProp name="RESPONSE_DATA">Dummy Sampler used to simulate requests and responses
without actual network activity. This helps debugging tests.</stringProp>
          <stringProp name="RESPONSE_TIME"></stringProp>
          <stringProp name="LATENCY"></stringProp>
          <stringProp name="CONNECT"></stringProp>
          <stringProp name="URL"></stringProp>
          <stringProp name="RESULT_CLASS">org.apache.jmeter.samplers.SampleResult</stringProp>
        </kg.apc.jmeter.samplers.DummySampler>
        <hashTree/>
      </hashTree>
      <PostThreadGroup guiclass="PostThreadGroupGui" testclass="PostThreadGroup" testname="**** tearDown Thread Group ****" enabled="true">
        <stringProp name="TestPlan.comments">This ThreadGroup will be always execute at last, Any connection like DB connection , OutputStream can be closed in this ThreadGroup or variable can be deallocated.</stringProp>
        <stringProp name="ThreadGroup.num_threads">1</stringProp>
        <stringProp name="ThreadGroup.ramp_time">1</stringProp>
        <boolProp name="ThreadGroup.same_user_on_next_iteration">true</boolProp>
        <stringProp name="ThreadGroup.on_sample_error">continue</stringProp>
        <elementProp name="ThreadGroup.main_controller" elementType="LoopController" guiclass="LoopControlPanel" testclass="LoopController" testname="Loop Controller" enabled="true">
          <boolProp name="LoopController.continue_forever">false</boolProp>
          <stringProp name="LoopController.loops">1</stringProp>
        </elementProp>
        <boolProp name="ThreadGroup.scheduler">false</boolProp>
        <stringProp name="ThreadGroup.duration"></stringProp>
        <stringProp name="ThreadGroup.delay"></stringProp>
      </PostThreadGroup>
      <hashTree/>
    </hashTree>
  </hashTree>
</jmeterTestPlan>

"@

# Issue came with direct using ${ So in template we have $'{ to avoid error weh have to replace so that it can be generated by powershell script}
$template = $template -replace 'jmeter="5.5"', "jmeter=`"$jmeterversion`""
$newtemplate = $template -replace '\$\''\{', '${'

#Write Complete JMX to UTF-8 encoded format direct writting is giving this error - 
# only whitespace content allowed before start tag and not \ufffd (position: START_DOCUMENT seen \ufffd... @1:2
[System.IO.File]::WriteAllLines($dir,$newtemplate)



# ##########################################################################################
# ##########################################################################################
#
Write-Output "***********************************************************"
Write-Output "Jmeter Standard Generic template(.jmx) created in this location - "$dir
Write-Output "***********************************************************"
Start-Sleep -Seconds 2