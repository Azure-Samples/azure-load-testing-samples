Write-Output "`n`n**** Azure load Test Setup and Execution - True ****"
Write-Output "`nStarting Azure load test configuration and execution"
Write-Output "`nNote: `n1. The converted JMX to ALT will be used in execution. `n2. We will use system-managed identity for integration with Keyvault and ALT resources. `n3. Threads, concurrency hits, and average response time are used to estimate execution costs. `n4. No suite will be modified based on concurrency; we will execute the JMX as created. `n5. Provide secrets, certificates, or environment variables as comma-separated values in double quotes. `n6. To generate a script for a specific URL, update the configuration in the portal, apply changes, and download the JMX file."
Start-Sleep -Seconds 2
$altjmxlocation = $jmxlocation -replace "\.jmx$", "_ALT.jmx"

#if File exists then continue else exit
if (Test-Path $altjmxlocation) {
    Write-Output "`nALT JMX location - $altjmxlocation"
}
else {
    Write-Output "File does not exist - $altjmxlocation"
    exit 1
}

#Calculating the total User Needed to perform the test
$totalVUs = $concurrenthitsneeded * $avgresponsetimeinsec
Write-Output "`nTotal VUs(Virtual Users) configured are - $totalVUs `n for duration - $durationinmin minutes"
    
    try {
        az config set core.login_experience_v2=off
        Write-Output "`nLogin to Azure "
        az login --tenant $tenantid

        if ($LASTEXITCODE -ne 0) {
            Write-Output "`nError: Failed to log in to Azure with tenant ID $tenantid. Please check the tenant ID and try again."
            exit 1
        }
        
        # Set subscription
        Write-Output "`nNow Setting the subscription to $subscription" 
        az account set --subscription $subscription
        # Creating Resource Group
        Write-Output "`nCreating the Resource Group $resourcegroup in $location"
        az group create --name $resourcegroup --location $location
        az extension add --upgrade -n load --yes
        az config set extension.dynamic_install_allow_preview=true
        # Creating ALT resource
        Write-Output "`nCreating the ALT resource altresource_$altresourcename in $location"
        az load create --name altresource_$altresourcename --resource-group $resourcegroup --location $location
        # Creating Load Test
        Write-Output "`nCreating the Load Test"
        # Check if Secrets are present than assign the Managed Identity to the ALT resource and add the Managed Identity to the Access Policies of Key Vault
        if($secrets.Length -gt 10)
        {
            $secretnew = $secrets -split ","
            
            # Assigning Managed Identity to the ALT resource
            Write-Output "`nEnabling System Managed Identity to the ALT resource"
            az load update --name altresource_$altresourcename --resource-group $resourcegroup --identity-type SystemAssigned

            # Adding the Managed Identity to the Access Policies of Key Vault
            Write-Output "`nAdding the Managed Identity to the Access Policies of Key Vault"
            # Get the keyvault name from secret URI
            $keyvaultname = $secrets -split ".vault.azure.net/secrets/"
            $keyvaultname = $keyvaultname[0] -replace "https://", ""
            $keyvaultname = $keyvaultname -split "=", ""
            $keyvaultname = $keyvaultname[1]
            Write-Output "`nKey Vault Name: $keyvaultname"
            az keyvault set-policy --name $keyvaultname --resource-group $keyvaultresourcegroup --object-id (az load show --name altresource_$altresourcename --resource-group $resourcegroup --query identity.principalId -o tsv) --secret-permissions get list --certificate-permissions get list --key-permissions get list
        }
        else {
            $secretnew = ""
        }    
        if($certificates.Length -gt 10)
        {
            $certnew = $certificates -split ","
        }
        else {
            $certificates = ""
        }
        if($environment.Length -gt 10)
        {
            $envnew = $environment -split ","
        }
        else {
            $environment = ""
        }    
    }
    catch {
        Write-Output "`nError in creating the resource group or ALT resource - Please check the execution logs"
        exit 1
    }

    try 
    {
        $parameters = @()
        if ($secretnew.Length -gt 0) {
            foreach ($secret in $secretnew) {
                $parameters += "--secret"
                $parameters += $secret
            }
        }
        
        # Format and add --certificate arguments
        if ($certnew.Length -gt 0) {
            foreach ($certificate in $certnew) {
                $parameters += "--certificate"
                $parameters += $certificate
            }
        }
        
        # Format and add --env arguments
        if ($envnew.Length -gt 0) {
            foreach ($env in $envnew) {
                $parameters += "--env"
                $parameters += $env
            }
        }
        
        az load test create --load-test-resource altresource_$altresourcename --resource-group $resourcegroup --test-id testid$altresourcename --display-name SampleTest$altresourcename --description "Perf Starter Kit - sample load test" --test-plan $altjmxlocation --engine-instances $engineinstances @parameters

        # Executing Load Test
        Write-Output "`n Executing the Load Test, Please wait for the test to complete ..."
        $testid = Get-Date -Format "yyyy-MM-dd_HH-mm"
        $altresultinjson = az load test-run create --load-test-resource altresource_$altresourcename --resource-group $resourcegroup --test-id testid$altresourcename --test-run-id testid_$testid
        Write-Output "`n*** Test is completed you can see the results in the portal URL ***"
        # wait for the above command to complete it will give the portal url to see the ALT page.  
        $altresultinjson | ConvertFrom-Json
        # Read portalUrl from the json
        $altresultUrl = $altresultinjson | ConvertFrom-Json | Select-Object -ExpandProperty portalUrl
        Write-Output "`nPortal URL: $altresultUrl"
        Write-Output "***********************************************"
        Write-Output "    Azure load testing Setup/Execution Completed     "
        Write-Output "***********************************************"
    }
    catch
    {
        Write-Output "`nError in executing the test - Please check the execution logs"
        exit 1
    }