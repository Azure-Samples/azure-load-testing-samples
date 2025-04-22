## Description: This script will download the latest version of JMeter ##
Write-Output "`n***********************************************"
Write-Output "Starting JAVA Setup with Latest Version"
Write-Output "***********************************************"

# Start-Sleep -Seconds 2

## Variables ##
$os = ""
$javaext = ""
$javadownloadlocation = ""
$javaurlinternet = ""
$javaversion = ""
$javainstalledlocation = ""

## Checking the OS ##
Write-Host "Starting Jmeter Starter Kit \n Checking the OS"
if ($ENV:OS -match "Windows") {
    Write-Host "Windows"
    $os = "windows"
    $javaext = ".exe"
    $javadownloadlocation = "C:\Users\Public\"
    $javainstalledlocation = "C:\Program Files\Java\"
    $javainstalledlocation = $javainstalledlocation+$javaurlinternet.Replace("https://download.oracle.com/java/","jdk-").Replace("latest/"+$javaversion,"")
}
else {
    Write-Host "Linux"
    $os = "linux"
    $javadownloadlocation = "/usr/local/" 
    $javaext = ".tar.gz"
    $javainstalledlocation = "/usr/lib/jvm/"
}

## Get Java latest version all URLs ##
$WebResponseObj = Invoke-WebRequest -Uri "https://www.oracle.com/java/technologies/downloads/"
$list = $WebResponseObj.Links | Select-Object href
foreach ($item in $list) {
    $href = $item.href
    if($href -match "https://download.oracle.com/java" -and $href -match $os -and $href -match $javaext) {
        $javaurl = $href
        Write-Host $javaurl
        $javaurlinternet = $javaurl
        $javaversion = (Split-Path $javaurlinternet -Leaf)
        break 
    }   
}

#Download Java#
Write-Host "Now Downloading the Java = "$javaurlinternet
$javadownloadlocation = $javadownloadlocation.Trim()+$javaversion
Write-Host $javadownloadlocation
Write-Host "Downloading Java - "$javaurlinternet 
Invoke-WebRequest -Uri $javaurlinternet -OutFile $javadownloadlocation
Write-Host "JAVA Download Complete"



# Extract Java Based on different OS ##
if ($javaext -match ".exe") { #Windows
    Write-Host "Installing Java - "$javadownloadlocation
    Start-Process -FilePath $javadownloadlocation -ArgumentList "/s" -Wait
    Write-Host "Java Installation Completed"
    $javainstalledlocation = $javainstalledlocation + "jdk-" + $javaurlinternet.Substring($javaurlinternet.LastIndexOf("jdk-")+4, $javaurlinternet.LastIndexOf("-")-$javaurlinternet.LastIndexOf("jdk-")-4).Replace("_windows","")
    ## Set Environment Variables ##
    $env:JAVA_HOME = $javadownloadlocation
    #powershell add to path
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + $javainstalledlocation + "\bin"
    [System.Environment]::SetEnvironmentVariable("Path", $env:Path, "Machine")
    Write-Host "Environment Set Variables Completed"
}
else { #Linux
    Write-Host "Extracting Java - "$javadownloadlocation
    tar -xvzf $javadownloadlocation -C $javadownloadlocation
    Write-Host "Java Extracted"
    #powershell add variable to path in linux 
    Write-Output 'export JAVA_HOME='$javainstalledlocation >> ~/.bashrc
    Write-Output 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc
    source ~/.bashrc
    ## Set Environment Variables ##
    $env:JAVA_HOME = $javadownloadlocation
    #powershell add to path
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + $javainstalledlocation + "\bin"
    [System.Environment]::SetEnvironmentVariable("Path", $env:Path, "Machine")
    Write-Host "Environment Set Variables Completed"
}

Write-Output "***********************************************"
Write-Output "JAVA Setup Completed with Latest Version"
Write-Output "***********************************************"
# Description: This script will download the latest version of Java ##