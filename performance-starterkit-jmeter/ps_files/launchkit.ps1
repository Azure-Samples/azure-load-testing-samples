# Requires -RunAsAdministrator
# if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
#     # Restart the script with elevated privileges
#     Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
#     exit
# }
##########################################################################################
##########################################################################################
Write-Output "*****************************************************************************************"
Write-Output "Welcome to JMETER Starter Kit 'A one stop solution' loaded with the following features:`n1. JAVA Download and installation as JMeter prerequisite `n2. JMeter Download and Setup `n3. Environment Variable setup for Java and JMeter `n4. Create JMeter script Master Template (For majority of script reference)`n5. JMeter suite creation as per Swagger or APIM `n6. JMeter HTML Reporting Creation from .jtl`n7. Conversion of your JMX to ALT compatible `n8. Azure load Test Setup and Execution(CLI should be installed for running this feature)"
Write-Output "*****************************************************************************************"
Start-Sleep -Seconds 2
Write-Output "`nExamining the config.properties file to retrieve parameters and determine enabled features for execution or processing"
Write-Output "**************************************************************************************"

$errorflag = 0
$featureflag = 0
function readpropertyfile{
    param(
        [string]$file,
        [string]$key
    )
    $file_content = Get-Content $file
    $file_content = $file_content -join [Environment]::NewLine
    $configuration = ConvertFrom-StringData($file_content)
    $value = $configuration.$key
    return $value
}

#powershell to get current directory path
$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
$rootfolder = Split-Path -Path $dir -Parent
if ($ENV:OS -match "Windows")
{
    $dir = $dir + "\"
    $file = $rootfolder + "\config_input_files\config.properties"
}
else
{
    $dir = $dir + "/"
    $file = $rootfolder + "/config_input_files/config.properties"
}

# $file = $file + "config.properties"
$starterkitsetup = (readpropertyfile -file $file -key "starterkitsetup")
$reportgeneration = (readpropertyfile -file $file -key "reportgeneration")
$suitegenerationfromswagger = (readpropertyfile -file $file -key "suitegenerationfromswagger")
$suitegenerationfromapimconfig = (readpropertyfile -file $file -key "suitegenerationfromapimconfig")
$jmxconversionneeded = (readpropertyfile -file $file -key "jmxconversionneeded")
$altsetup = (readpropertyfile -file $file -key "altsetup")

# Validation of Above Variables
if ($altsetup -ne "true" -and $altsetup -ne "false") {
    throw "Invalid value for 'altsetup': $altsetup. Expected 'true' or 'false'."
}
if ($jmxconversionneeded -ne "true" -and $jmxconversionneeded -ne "false") {
    throw "Invalid value for 'jmxconversionneeded': $jmxconversionneeded. Expected 'true' or 'false'."
}
if ($suitegenerationfromapimconfig -ne "true" -and $suitegenerationfromapimconfig -ne "false") {
    throw "Invalid value for 'suitegenerationfromapimconfig': $suitegenerationfromapimconfig. Expected 'true' or 'false'."
}
if ($suitegenerationfromswagger -ne "true" -and $suitegenerationfromswagger -ne "false") {
    throw "Invalid value for 'suitegenerationfromswagger': $suitegenerationfromswagger. Expected 'true' or 'false'."
}
if ($reportgeneration -ne "true" -and $reportgeneration -ne "false") {
    throw "Invalid value for 'reportgeneration': $reportgeneration. Expected 'true' or 'false'."
}
if ($starterkitsetup -ne "true" -and $starterkitsetup -ne "false") {
    throw "Invalid value for 'starterkitsetup': $starterkitsetup. Expected 'true' or 'false'."
}


#Read Duration and User count from config.properties to show the cost of the test
$durationinmin = [int](readpropertyfile -file $file -key "durationinmin")
$global:durationinmin = $durationinmin
$concurrenthitsneeded = [int](readpropertyfile -file $file -key "concurrenthitsneeded")
$global:concurrenthitsneeded = $concurrenthitsneeded
$avgresponsetimeinsec = [int](readpropertyfile -file $file -key "avgresponsetimeinsec")
$global:avgresponsetimeinsec = $avgresponsetimeinsec
$secrets = (readpropertyfile -file $file -key "secrets")
if ($null -eq $secrets) {
    $secrets = ""
}
$global:secrets = $secrets
$certificates = (readpropertyfile -file $file -key "certificates")
if ($null -eq $certificates) {
    $certificates = ""
}
$global:certificates = $certificates
$environment = (readpropertyfile -file $file -key "environment")
if ($null -eq $environment) {
    $environment = ""
}
$global:environment = $environment
$tenantid = (readpropertyfile -file $file -key "tenantid")
$global:tenantid = $tenantid
$subscription = (readpropertyfile -file $file -key "subscription")
$global:subscription = $subscription
$resourcegroup = (readpropertyfile -file $file -key "resourcegroup")
$global:resourcegroup = $resourcegroup
$keyvaultresourcegroup = (readpropertyfile -file $file -key "keyvaultresourcegroup")
$global:keyvaultresourcegroup = $keyvaultresourcegroup
$location = (readpropertyfile -file $file -key "location")
$global:location = $location
$engineinstances = [int](readpropertyfile -file $file -key "engineinstances")
$global:engineinstances = $engineinstances
$altresourcename = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$global:altresourcename = $altresourcename
$jmxlocation = (readpropertyfile -file $file -key "jmxlocation")
$global:jmxlocation = $jmxlocation
$jmeterversion = (readpropertyfile -file $file -key "jmeterversion")
$global:jmeterversion = $jmeterversion

# Validation of Above Variables
if ($durationinmin -le 0) {
    throw "Invalid value for 'durationinmin': $durationinmin. Expected a positive integer greater than 0."
}

if ($concurrenthitsneeded -le 0) {
    throw "Invalid value for 'concurrenthitsneeded': $concurrenthitsneeded. Expected a positive integer greater than 0."
}

if ($avgresponsetimeinsec -le 0) {
    throw "Invalid value for 'avgresponsetimeinsec': $avgresponsetimeinsec. Expected a positive integer greater than 0."
}

if ($engineinstances -le 0) {
    throw "Invalid value for 'engineinstances': $engineinstances. Expected a positive integer greater than 0."
}

if ($altsetup -eq "true" -and ($jmxlocation -eq "" -and $jmxlocation -notmatch ".jmx")) {
    throw "JMX path is needed in jmxlocation variable in configproperty file, Invalid value for 'jmxlocation': $jmxlocation. Expected jmx path"
}

if ($altsetup -eq "true" -and $jmxconversionneeded -eq "false" ) {
    throw "JMX conversion is needed for Azure Load Test, Please set jmxconversionneeded to true in configproperty file and try again"
}

#Check $secret contains https:// or not
if ($altsetup -eq "true" -and $secrets -ne "" -and $secrets -notmatch "https://") {
    throw "Invalid value for 'secrets': $secrets. Expected a valid URL."
}

if ($altsetup -eq "true" -and $certificates -ne "" -and $certificates -notmatch "https://") {
    throw "Invalid value for 'certificates': $certificates. Expected a valid URL"
}

if ($altsetup -eq "true" -and $environment -ne "" -and $environment -eq "") {
    throw "Invalid value for 'environment': $environment. Expected a non-empty string."
}

if ($starterkitsetup -eq 'true') {
    $featureflag++
    Write-Output "`n`nStarterkitsetup is set to true, so we will proceed with the setup"
    Write-Output "`nThis will now run multiple scripts to install Java, JMeter, Download Plugins and Create Template"
    # Powershell script to install Java and JMeter
    Write-Host "`nChecking Java Installation"
    if ($env:Path -match "java" -or $env:Path -match "Java" -or $env:Path -match "JAVA") {
        Write-Host "Java is already installed"
    }
    else {
        Write-Host "`nJava is not installed"
        Write-Host "Installing Java"
        if ($ENV:OS -match "Windows")
        {
            .$rootfolder\ps_files\javasetup.ps1
        }
        else {
            .$rootfolder/ps_files/javasetup.ps1
        }    
    }

    if ($ENV:OS -match "Windows")
    {
        .$rootfolder\ps_files\jmetersetup.ps1
        .$rootfolder\ps_files\downloadjmeterplugin.ps1
        Write-Output "`n***** JMeter Setup is completed and ready to use *****"
        .$rootfolder\ps_files\createtemplate.ps1
    }
    else {
        .$rootfolder/ps_files/jmetersetup.ps1
        .$rootfolder/ps_files/downloadjmeterplugin.ps1
        Write-Output "`n***** JMeter Setup is completed and ready to use *****"
        .$rootfolder/ps_files/createtemplate.ps1
    } 
}
 
if ($reportgeneration -eq 'true') {
    $featureflag++
    Write-Output "`n`nReport Generation from jtl is set to true, so we will proceed with the report generation"
    $jtlpath = (readpropertyfile -file $file -key "jtlpath")
    #Check if file path is valid or not
    try {
        if (-not (Test-Path $jtlpath)) {
            throw "Invalid JTL file path: $jtlpath. Please check the path and try again."
        }
        else{
            $directoryPath = Split-Path -Path $jtlpath -Parent
            if ($ENV:OS -match "Windows")
            {
                $resultsPath = "$directoryPath\jtlfilereport\"
            }
            else {
                $resultsPath = "$directoryPath/jtlfilereport/"
            }    
            Write-Output "Results Path: $resultsPath"

            # Empty the results folder if it exists
            if (Test-Path -Path $resultsPath) {
                Get-ChildItem -Path $resultsPath -Recurse | Remove-Item -Force -Recurse
                Write-Output "The results folder has been emptied."
            }
            if ($ENV:OS -match "Windows")
            {
                Write-Output "Generating Report for JTL file at Windows"
                try {
                    jmeter -g $jtlpath -o $directoryPath\jtlfilereport\
                    Write-Output "***** Report is generated at $directoryPath\results\jtlfilereport\ *****"
                } catch {
                    Write-Output "Issue in creating Report. Please check the JTL file path or JMeter is installed or not"
                    Write-Warning -Message "Oops, ran into an issue"
                }
            }
            else
            {
                try {
                    jmeter -g $directoryPath/results.jtl -o $directoryPath/jtlfilereport\
                    Write-Output "***** Report is generated at $directoryPath/results/jtlfilereport/ *****"    
                } catch{
                    Write-Output "Issue in creating Report. Please check the JTL file path or JMeter is installed or not"
                    Write-Warning -Message "Oops, ran into an issue"
                }        
            }
        }
    } catch {
        Write-Output "Proceeding with next feature as JTL file path is not valid"
    }    
}

if ($suitegenerationfromswagger -eq 'true') {
    $featureflag++
    Write-Output "`n`nSuite generation from Swagger is set to true, so we will proceed with jmx creation based on Swagger"
    $swaggerjsonpath = (readpropertyfile -file $file -key "swaggerjsonpath")
    #Check if file path is valid or not
    try{
        if (-not (Test-Path $swaggerjsonpath)) {
            # Write-Output "Invalid Swagger JSON file path: $swaggerjsonpath. Please check the path and try again."
            throw "Invalid Swagger JSON file path: $swaggerjsonpath. Please check the path and try again."
        }
        else {
            $global:swaggerjsonpath = $swaggerjsonpath
            if ($ENV:OS -match "Windows")
            {
                .$rootfolder\ps_files\createsuitefromswagger.ps1
            }
            else {
                .$rootfolder/ps_files/createsuitefromswagger.ps1
            } 
        }
    } catch {
        Write-Output "Proceeding with next feature as Swagger JSON file path is not valid"
    }
       
}
if ($suitegenerationfromapimconfig -eq 'true') {
    Write-Output "`n`nSuite generation from APIM is set to true, so we will proceed with jmx creation based on APIM"
    $apimconfigpath = (readpropertyfile -file $file -key "apimconfigpath")
    #Check if file path is valid or not
    try {
        if (-not (Test-Path $apimconfigpath)) {
            # Write-Output "Invalid APIM config file path: $apimconfigpath. Please check the path and try again."
            throw "Invalid APIM config file path: $apimconfigpath. Please check the path and try again."
        }
        else
        {
            $global:apimconfigpath = $apimconfigpath
            if ($ENV:OS -match "Windows")
            {
                .$rootfolder\ps_files\createsuitefromapimconfig.ps1
            }
            else {
                .$rootfolder/ps_files/createsuitefromapimconfig.ps1
            }
        }
    } catch {
        Write-Output "Proceeding with next feature as APIM config file path is not valid"
    }

}

if ($jmxconversionneeded -eq 'true') {
    Write-Output "`n`nJMX conversion is true, so we will proceed with jmx conversion based on ALT guidelines"
    $featureflag++
    if ($ENV:OS -match "Windows")
    {
       #Call jmxconvertor.ps1
       .$rootfolder\ps_files\convertjmx_altjmx.ps1
    }
    else {
        #Call jmxconvertor.ps1
       .$rootfolder/ps_files/convertjmx_altjmx.ps1
    } 
}

if ($altsetup -eq 'true') {
    Write-Output "`n`nAzure Load Test setup and execution is set to true, so we will proceed with this features"
    $featureflag++
    Write-Output "`nChecking Azure CLI Installation"
    if ($ENV:OS -match "Windows")
    {
       #Invoke alt
       if (Get-Command az -ErrorAction SilentlyContinue) {
            Write-Output "Azure CLI is installed."
            .$rootfolder\ps_files\alt.ps1
        } else {
            Write-Output "Azure CLI is not installed. Please install and try again"
            $errorflag = 1
        }
       
    }
    else {
        #Invoke alt
        if (Get-Command az -ErrorAction SilentlyContinue) {
            Write-Output "Azure CLI is installed."
            .$rootfolder/ps_files/alt.ps1
        } else {
            Write-Output "`nAzure CLI is not installed. Please install and try again"
            $errorflag = 1
        }
    } 
}

if ($errorflag -eq 1) {
    Write-Output "`n`n*****  JMeter Starter Kit is completed with errors *****"
    Write-Output "Kindly check the logs or reach out to shivam.maralay@microsoft.com for resolution"
}
elseif ($featureflag -eq 0) {
    Write-Output "`n`n***** No feature selected to run. If something is missing, please update the config property file, set all options to true, and try again ***"
}
else {
    Write-Output "`n`n*****  JMeter Starter Kit is completed   *****"
    Write-Output "Kindly reach out to shivam.maralay@microsoft.com for any Suggestion or Feedback"
}
