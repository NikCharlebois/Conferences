param ( 
    [parameter(Mandatory = $true)]
    [string]$TargetEnvironment
)
Write-Host "Creating Resource Group..." -NoNewLine
$rg = (New-AzureRmResourceGroup -Name "CollabSummit$($TargetEnvironment)" -Location WestUS).ResourceGroupName
Write-Host "Done" -ForegroundColor Green

$templateFile = ".\azuredeploy.json"
Write-Host "Deploying ARM Template..."
New-AzureRmResourceGroupDeployment -Verbose `
    -ResourceGroupName $rg `
    -TemplateFile $templateFile