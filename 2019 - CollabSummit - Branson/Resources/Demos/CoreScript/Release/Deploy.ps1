$path = "$env:SYSTEM_ARTIFACTSDIRECTORY\Build\DSC\" + $args[0] + ".psd1"
$ConfigData = Get-Content $path | Out-String | Invoke-Expression
$azAccount = Get-AzureRMAutomationAccount -ResourceGroupName NACS -Name CollabSummit
$azAccount | Import-AzureRMAutomationDSCConfiguration -SourcePath "$env:SYSTEM_ARTIFACTSDIRECTORY\Build\DSC\Core.ps1" -Published -Force
$azAccount | Start-AzureRmAutomationDscCompilationJob -ConfigurationName Core -ConfigurationData $ConfigData
