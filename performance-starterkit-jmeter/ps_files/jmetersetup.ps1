## Description: This script will download the latest version of JMeter ##
Write-Output "`n***********************************************"
Write-Output "Starting JMETER Setup with Latest Version"
Write-Output "***********************************************"

# Start-Sleep -Seconds 2

## Variables ##
$jmeterext = ""
$jmeterurl = ""
$jmeterdownloadlocation = ""
$jmeteroutFile = ""

## Checking the OS ##
Write-Host "Starting Jmeter Starter Kit.. "
Write-Host "Checking the OS"
if ($ENV:OS -match "Windows") {
    Write-Host "Windows"
    $jmeterext = ".zip"
    $jmeterdownloadlocation = "C:\Users\Public\"
}
else {
    Write-Host "Linux"
    $jmeterext = ".tgz"
    $jmeterdownloadlocation = "/usr/local/" 
}

    ## Get Jmeter latest version all URLs ##
$WebResponseObj = Invoke-WebRequest -Uri "https://jmeter.apache.org/download_jmeter.cgi"
$list = $WebResponseObj.Links | Select-Object href
foreach ($item in $list) {
    $href = $item.href
    if($href -match "dlcdn.apache.org//jmeter/binaries" -and $href -match $jmeterext) {
        $jmeterurl = $href
        $jmeterext = (Split-Path $jmeterurl -Leaf)
    }
}
$jmeteroutFile = $jmeterdownloadlocation+$jmeterext.Trim()

if ($env:Path -match "jmeter" -or $env:Path -match "Jmeter" -or $env:Path -match "JMETER") {
    Write-Host "JMeter is already installed but the plugins will be downloaded/Overwritten"
}
else {
    ## Downloading Jmeter ##
    Write-Host "JMeter not found, Downloading the latest version of JMeter = "$jmeterurl
    Write-Host "Downloading JMeter in this location: "$jmeteroutFile" from "$jmeterurl
    Invoke-WebRequest -Uri $jmeterurl -OutFile $jmeteroutFile
    Write-Host "JMETER Download Complete"

    ## Extract Jmeter Based on different OS ##
    if ($jmeterext -match ".zip") {
        Write-Host "Extracting JMeter - "$jmeteroutFile
        Expand-Archive -Path $jmeteroutFile -DestinationPath $jmeterdownloadlocation
        Write-Host "Extrating JMeter Completed"
    }
    else {
        Write-Host "Extracting JMeter - "$jmeteroutFile
        tar -xvzf $jmeteroutFile -C $jmeterdownloadlocation
        Write-Host "JMeter Extracted"
    }
}

    ## Setting Environment Variables ##
Write-Host "Setting up Environment Variables"
$jmeterdownloadlocation = $jmeterdownloadlocation + (Split-Path $jmeteroutFile -Leaf).Replace(".zip","").Replace(".tgz","")
write-Host $jmeterdownloadlocation
    ## Set Environment Variables ##
$env:JMETER_HOME = $jmeterdownloadlocation
    # powershell add to path
if ($ENV:OS -match "Windows") {
    if ($env:Path -match "jmeter" -or $env:Path -match "Jmeter" -or $env:Path -match "JMETER") {
        Write-Host "JMeter is already installed in the Path, So not making an Entry"
    }
    else {
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + $env:JMETER_HOME + "\bin"
    }    
}else {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + $env:JMETER_HOME + "/bin"
}
[System.Environment]::SetEnvironmentVariable("Path", $env:Path, "Machine")
Write-Host "Environment Set Variables Completed, ******* Recommended to restart the system *******"
    # Setting global Variable for Jmeter Location used in other scripts#
$global:jmeterlocation = $jmeterdownloadlocation

Write-Output "***********************************************"
Write-Output "JMETER Setup with Latest Version is completed"
Write-Output "***********************************************"