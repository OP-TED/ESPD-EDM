#       PowerShell tool for downloading external files v1.2
#
# This tool downloads external Code List files from EU Vocabulary   
# and from Github repository of ESPD EDM                            
# the URL and destiantions are specified in a JSON object           


# Convert String to Pwershell Array
$externalCL = Get-Content '.\external_code_list.json' | Out-String | ConvertFrom-Json
$env:proxy="http://proxy-t2-lu.welcome.ec.europa.eu:8012"
$proxyCredentials = Get-Credential -Message 'Please enter your credentials for the proxy server.'

# Loop thorough each external Code List and get the right version
Foreach ($ecl in $externalCL) {
    $fp = $ecl.folder + "\" + $ecl.filename
    Write-Host "processing $fp"
    if (Test-Path $fp -PathType leaf) {
        Remove-Item $fp
    }
    Invoke-WebRequest -Proxy $env:proxy -ProxyCredential $proxyCredentials -OutFile $fp -Uri $ecl.uri.replace('https://github.com/OP-TED/ESPD-EDM/tree', 'https://raw.githubusercontent.com/OP-TED/ESPD-EDM')
}
