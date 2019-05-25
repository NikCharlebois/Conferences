param ( 
    [parameter(Mandatory = $true)]
    [string]$TargetEnvironment,

    [parameter(Mandatory = $true)]
    [string]$TemplatePath
)
Write-Host "Creating Resource Group {CollabSummit$($TargetEnvironment)}..." -NoNewLine
$rg = Get-AzureRMResourceGroup "CollabSummit$($TargetEnvironment)" -ErrorAction SilentlyContinue
if ($null -eq $rg)
{
    $rg = (New-AzureRmResourceGroup -Name "CollabSummit$($TargetEnvironment)" -Location WestUS).ResourceGroupName
}
Write-Host "Done" -ForegroundColor Green

$templateFile = "$TemplatePath/Demo/Demo/CollabSummit/SharePoint2019/azuredeploy.json"
Write-Host "Deploying ARM Template..."
New-AzureRmResourceGroupDeployment -Verbose `
    -ResourceGroupName $rg `
    -TemplateFile $templateFile