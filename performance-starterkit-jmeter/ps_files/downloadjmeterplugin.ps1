# Description: This script is used to download jmeter plugin
Write-Output "`n`n***********************************************************"
Write-Output "Downloading JMeter Plugin based on config.properties"
Write-Output "***********************************************************"
$pluginmanagerlocation = "lib\ext\plugins-manager.jar"
# Start-Sleep -Seconds 2

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
$dir = Split-Path -Path $dir -Parent
if ($ENV:OS -match "Windows")
{
    $dir = $dir + "\config_input_files\"
    $jmeterlocation = $jmeterlocation + "\"
    $pluginmanagerlocation = $pluginmanagerlocation.Replace("/","\")
}
else
{
    $dir = $dir + "/config_input_files/"
    $jmeterlocation = $jmeterlocation + "/"
    $pluginmanagerlocation = $pluginmanagerlocation.Replace("\","/")
}
$file = $dir + "config.properties"

#Creating an array of plugins , so that in a loop download the plugin and putting in lib folder can be done#
$plugin = 1..6
$plugin[0] = "https://jmeter-plugins.org/files/packages/bzm-parallel-"+(readpropertyfile -file $file -key "bzm-parallel")+".zip"
$plugin[1] = "https://jmeter-plugins.org/files/packages/jpgc-dummy-"+(readpropertyfile -file $file -key "jpgc-dummy")+".zip"
$plugin[2] = "https://jmeter-plugins.org/files/packages/jpgc-casutg-"+(readpropertyfile -file $file -key "jpgc-casutg")+".zip"
$plugin[3] = "https://jmeter-plugins.org/files/packages/jpgc-tst-"+(readpropertyfile -file $file -key "jpgc-tst")+".zip"
$plugin[4] = "https://jmeter-plugins.org/files/packages/jmeter.backendlistener.azure-"+(readpropertyfile -file $file -key "jmeter.backendlistener.azure")+".zip"
$plugin[5] = "https://jmeter-plugins.org/files/packages/jpgc-webdriver-"+(readpropertyfile -file $file -key "jpgc-webdriver")+".zip"


function DownloadPlugin($pluginname)
{
    Write-Output "Downloading Plugin from $pluginname to $jmeterlocation"
    $jmeterlocation = $jmeterlocation + $pluginname.Split("/")[-1]
    Write-Output ""
        # download url for plugin 
    Invoke-WebRequest -Uri $pluginname -OutFile $jmeterlocation
}

#Download the plugins unzip and put in lib folder
foreach ($item in $plugin) {
    DownloadPlugin($item)
        #Unzip the plugins
    $zipfile = $jmeterlocation + $item.Split("/")[-1]
    $destination = $jmeterlocation
    Write-Output "Unzipping $zipfile to $destination"
    Expand-Archive -Path $zipfile -DestinationPath $destination -Force
        #Remove specific file from Jmeter/lib/ext folder.
    $filetoremove = $destination + "lib/ext/jmeter-plugins-manager-*.jar"
    Remove-Item $filetoremove
    #Remove-Item $zipfile
}

#Download the Latest Jmeter Plugin Manager to avoid and version clash
Write-Output "Downloading Jmeter Plugin Manager in this location - "$jmeterlocation$pluginmanagerlocation
Invoke-WebRequest -Uri "https://jmeter-plugins.org/get/" -OutFile $jmeterlocation$pluginmanagerlocation


Write-Output "***********************************************"
Write-Output "      Jmeter Plugin download Completed     "
Write-Output "***********************************************"