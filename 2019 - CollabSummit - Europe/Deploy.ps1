#Login-AzureRmAccount
Select-AzureRmSubscription "Consommation interne Microsoft Azure"
$rg1 = (New-AzureRmResourceGroup -Name TBD1 -Location WestUS).ResourceGroupName

$templateFile = "C:\GitHub\Conferences\2019 - CollabSummit - Europe\SharePoint2019\azuredeploy.json"
$adminUserName = "lcladmin"
$password = ConvertTo-SecureString "Pass@word!11" -AsPlainText -Force
$dnsLabelPrefix = "myvm-$(Get-Random)"
$windowsOsVersion = "2016-Datacenter"
New-AzureRmResourceGroupDeployment -Verbose `
    -ResourceGroupName $rg1 `
    -TemplateFile $templateFile `
    -adminUsername $adminUserName `
    -adminPassword $password