param ( 
    [parameter(Mandatory = $true)]
    [string]$TargetEnvironment
)
$DSCScriptPath         = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($PSScriptRoot, "SharePoint2019.ps1"))
$ConfigDataPath        = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($PSScriptRoot, "ConfigurationData-$($TargetEnvironment).psd1"))

$AutomationAccountName = "CollabSummit"
$ResourceGroupName     = "CollabSummit"
$WebFrontEndVM         = "SPWFE$ResourceGroupName"
$ApplicationVM         = "SPAPP$ResourceGroupName"
$SearchVM              = "SPSRC$ResourceGroupName"

Write-Output "Uploading the SharePoint Configuration into Azure Automation..."
Import-AzureRmAutomationDscConfiguration -SourcePath $DSCScriptPath -ResourceGroupName $ResourceGroupName -AutomationAccountName $AutomationAccountName -Published -Force

Write-Output "Compiling the SharePoint Configuration within Azure Automation..."
Start-AzureRmAutomationDscCompilationJob -ResourceGroupName $ResourceGroupName -AutomationAccountName $AutomationAccountName -ConfigurationName "SharePoint2019" -ConfigurationData $ConfigDataPath

#Write-Output "Registering the SQL Server with Azure Automation"
#Register-AzureRmAutomationDscNode -AzureVMResourceGroup $ResourceGroupName -AzureVMName $SQLServerName -AzureVMLocation $ResourceGroupLocation -NodeConfigurationName "SQL.localhost" -ActionAfterReboot ContinueConfiguration -RebootNodeIfNeeded $true -AutomationAccountName $MasterAutomationAccountName -ResourceGroupName $MasterResourceGroupName