Write-Output "`n`n**** Conversion of your JMX to ALT compatible - True ****"
Write-Output "Starting the conversion of input JMeter file to ALT Compatible JMX"
# Read file and convert it into String #
try{
    $samplejson = Get-Content $jmxlocation -Raw -ErrorAction Stop
}
catch {
    Write-Output "`nError reading the file: either the filepath is incorrect or there is no file at the specified path - $jmxlocation"
    exit 1
}

# CSV File Path Update #
$Allcsvdataset = $samplejson -split "<CSVDataSet guiclass"
foreach ($csvdataset in $Allcsvdataset) {
    if($csvdataset.contains("CSVDataSet")){
        # Write-Output $csvdataset
        $csvdatasetcontent = $csvdataset -split "</CSVDataSet>"
        # Getting filename #
        $filename = $csvdatasetcontent[0] -split "<stringProp name=`"filename`">"
        $filename = $filename[1] -split "</stringProp>"
        # Write-Output $filename[0]
        #Check if file exists
        if (-not (Test-Path $filename[0])) {
            Write-Output "`nError: The csv file does not exist at the specified path. Please check the file path and try again."
            exit 1
        }
        # Get Filename from Filepath 
        if ($filename[0].Contains("\")){   
            $filenamenew = $filename[0] -split "\\"
            $filenamenew = $filenamenew[-1]
            # Write-Output $filenamenew
            $samplejson = $samplejson -replace [regex]::Escape($filename[0]), $filenamenew
        }
        else
        {
            $filenamenew = $filename[0] -split "/"
            $filenamenew = $filenamenew[-1]
            # Write-Output $filenamenew
            $samplejson = $samplejson -replace [regex]::Escape($filename[0]), $filenamenew
        }    
    }
}

# Update the User Defined Variables #
# If User Defined Variables are present in the JMX file # 
$allenvvariables = $environment -split ","
$allenvvariables = $allenvvariables -replace "`"",""
$newvalue = ""
$allkeys = ""
if($samplejson.Contains("<Arguments guiclass=`"ArgumentsPanel`" testclass=`"Arguments`"") -eq $true){
    #Count if there is more than 1 UserDefined we will be just changing the first one
    $count = ($samplejson -split "<Arguments guiclass=`"ArgumentsPanel`" testclass=`"Arguments`"").Count
    # Write-Output $count
    if($count -gt 2){
        Write-Output "`n We found that more than 1 User Defined Variables are present in the JMX file so we will be considering the first User Defined Variable"
    }
    $Allargumentpanelstart = $samplejson -split "<Arguments guiclass=`"ArgumentsPanel`" testclass=`"Arguments`""
    $Allargumentpanelstart1 = $Allargumentpanelstart[1] -split "<collectionProp name=`"Arguments.arguments`">"
    $Allargumentpanel = $Allargumentpanelstart1[1] -split "</collectionProp>"
}         
else {
    #Check if Environment Variables or secret is present in the config.properties
    if ($environment.Length -gt 10 -or $secrets.Length -gt 10){ 
        # Step 2 - Add User Defined Variables #
        $jmxinitial = $samplejson -split "</TestPlan>"
        $ud1 = $jmxinitial[1] -split "<hashTree>"
        $jmetersec = ""
        foreach ($ud in $ud1) {
            if($ud.Length -gt 10){
                $jmetersec = $jmetersec + $ud + "<hashTree>"
            }
        }
    }    
}

foreach ($envvariables in $allenvvariables) {
    $envkeyvalue = $envvariables -split "="
    $envkey = $envkeyvalue[0]
    $envvalue = "`${__groovy(System.getenv(`""+$envkey+"`"))}"
    #Check if envkey is present in the samplejson
    $newvalue = $newvalue +
        "<elementProp name=`"$envkey`" elementType=`"Argument`">
            <stringProp name=`"Argument.name`">$envkey</stringProp>
            <stringProp name=`"Argument.value`">$envvalue</stringProp>
            <stringProp name=`"Argument.metadata`">=</stringProp>
        </elementProp>"
    $allkeys = $allkeys + $envkey + ","    
}   

#Add Secret#
$allsecret = $secrets -split ","
$allsecret = $allsecret -replace "`"",""
if($allsecret.Length -gt 0){
    foreach ($secretvariables in $allsecret) {
        $secretkeyvalue = $secretvariables -split "="
        $secretkey = $secretkeyvalue[0]
        $secretvalue = "`${__GetSecret("+$secretkey+")}"
        #Check if envkey is present in the samplejson
        $newvalue = $newvalue +
            "<elementProp name=`"$secretkey`" elementType=`"Argument`">
                <stringProp name=`"Argument.name`">$secretkey</stringProp>
                <stringProp name=`"Argument.value`">$secretvalue</stringProp>
                <stringProp name=`"Argument.metadata`">=</stringProp>
            </elementProp>"
        $allkeys = $allkeys + $secretkey + ","    
    }
}
#Get Older UserDefinedValues#
if($samplejson.Contains("<Arguments guiclass=`"ArgumentsPanel`" testclass=`"Arguments`"") -eq $true){
    $stringProps = $Allargumentpanel[0] -split "<stringProp name=`"Argument.name`">"
    foreach ($stringProp in $stringProps) 
    {
        if($stringProp.Length -gt 5 -and $stringProp.Contains("</stringProp>"))
        {
            # Write-Output $stringProp
            $keyarg = $stringProp -split "</stringProp>"
            $key = $keyarg[0]
            # Write-Output $key
            $valuearg = $stringProp -split "<stringProp name=`"Argument.value`">"
            $value = $valuearg[1] -split "</stringProp>"
            $envvalue = $value[0]
            #Check if key is already present in Secret or in Environment#
            if ($allkeys.Contains($key) -eq $false){ 
                $newvalue = $newvalue +
                    "<elementProp name=`"$key`" elementType=`"Argument`">
                        <stringProp name=`"Argument.name`">$key</stringProp>
                        <stringProp name=`"Argument.value`">$envvalue</stringProp>
                        <stringProp name=`"Argument.metadata`">=</stringProp>
                    </elementProp>"
            }
        }  
    }
    if($count -gt 2){
        $content = ""
        for($i=2; $i -lt $count; $i++){
            $content = $content  + "<Arguments guiclass=`"ArgumentsPanel`" testclass=`"Arguments`""+$Allargumentpanelstart[$i]
        }
        $newjmxcontent = $Allargumentpanelstart[0] + "<Arguments guiclass=`"ArgumentsPanel`" testclass=`"Arguments`" testname=`"User Defined Variables`" enabled=`"true`"><collectionProp name=`"Arguments.arguments`">"+$newvalue+"</collectionProp>" + $Allargumentpanel[1]+ $content 
    }
    else
    {
        $newjmxcontent = $Allargumentpanelstart[0] + "<Arguments guiclass=`"ArgumentsPanel`" testclass=`"Arguments`" testname=`"User Defined Variables`" enabled=`"true`"><collectionProp name=`"Arguments.arguments`">"+$newvalue+"</collectionProp>" + $Allargumentpanel[1]
    }
}
else{
    $newjmxcontent = $jmxinitial[0] + "</TestPlan>" + "<hashTree>" + "<Arguments guiclass=`"ArgumentsPanel`" testclass=`"Arguments`" testname=`"User Defined Variables`" enabled=`"true`"><collectionProp name=`"Arguments.arguments`">"+$newvalue+"</collectionProp></Arguments><hashTree/>" +$jmetersec
}
 



#Create file from newjmxcontent
$NewjmxFile = $jmxlocation -replace "\.jmx$", "_ALT.jmx"
$newjmxcontent | Set-Content $NewjmxFile
Write-Output "The input JMeter file has been upgraded to a version compatible with ALT and is generated at the following path - `n$NewjmxFile"