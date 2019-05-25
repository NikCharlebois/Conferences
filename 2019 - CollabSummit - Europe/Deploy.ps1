param ( 
    [parameter(Mandatory = $true)]
    [string]$TargetEnvironment
)
$rg = (New-AzureRmResourceGroup -Name "CollabSummit$($TargetEnvironment)" -Location WestUS).ResourceGroupName

$templateFile = ".\azuredeploy.json"
$adminUserName = "lcladmin"
$password = ConvertTo-SecureString "Pass@word!11" -AsPlainText -Force

New-AzureRmResourceGroupDeployment -Verbose `
    -ResourceGroupName $rg `
    -TemplateFile $templateFile `
    -adminUsername $adminUserName `
    -adminPassword $password