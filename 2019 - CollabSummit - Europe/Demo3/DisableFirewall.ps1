Configuration DisableFirewall
{
    param (
        [parameter(Mandatory = $true)]         
        [System.Int32] 
        $Port,

        [parameter(Mandatory = $true)]
	[System.String] 
	$RuleName
    )
    Import-DSCResource -ModuleName NetworkingDSC

    $CredsSPFarm = Get-AutomationPSCredential -Name "CredsSPFarm"
    Node localhost
    {
            FireWall SQLFirewallRule
            {
                Name        = "DisableFireWallForSQL"
                LocalPort 	= $Port
                DisplayName = $RuleName
                Group       = 'SQL Rule Group'
                Ensure      = 'Present'
                Enabled     = 'True'
                Profile     = ('Domain', 'Private')
                Direction   = "Inbound"
                Protocol    = "TCP"
            }
    }
}