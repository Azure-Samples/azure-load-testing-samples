$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
$zipFilePath = Join-Path -Path $scriptDirectory -ChildPath "csv.zip"
$destinationPath = Join-Path -Path $scriptDirectory -ChildPath "extracted"

# Extract the Zip file
Expand-Archive -Path $zipFilePath -DestinationPath $destinationPath
$extractedPath = Join-Path -Path $destinationPath -ChildPath "csv"
# Get all CSV files in the extracted folder
$csvFiles = Get-ChildItem -Path $extractedPath -Filter "*.csv"

# Open each CSV file, add a column with the engine number and append all the rows to the combined output
$combinedOutput = foreach ($csvFile in $csvFiles) {
    $engineNumber = $csvFile.BaseName -replace "[^0-9]" , ''
    $content = Import-Csv -Path $csvFile.FullName
    $content | Add-Member -MemberType NoteProperty -Name 'EngineNumber' -Value $engineNumber -PassThru
}
# Export the combined data to a new CSV file 
$combinedOutput | Export-Csv -Path "combined.csv" -NoTypeInformation