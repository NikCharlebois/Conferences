$nodeConfigs = Get-AzureRmAutomationDscNodeConfiguration -ResourceGroupName "NACS" -AutomationAccountName "CollabSummit"
$vms = Get-AzureRMVM -ResourceGroupName "NACS"

foreach ($nodeConfig in $nodeConfigs)
{
    $configName = $nodeConfig.Name.Split('.')[1]
    $vmToAssign = $vms | ?{$_.Name -eq $configName}

    if ($null -ne $vmToAssign)
    {
        Register-AzureRmAutomationDscNode -AzureVMName $vmToAssign.Name -NodeConfigurationName $nodeConfig.Name -AzureVMLocation "East US" -ResourceGroupName "NACS" -AutomationAccountName "CollabSummit"
    }
}