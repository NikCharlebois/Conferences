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
    Import-DSCResource -ModuleName xNetworking

    Node localhost
    {
            xFireWall SQLFirewallRule
            {
                Name        = "DisableFireWallForSQL"
                LocalPort   = $Port
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