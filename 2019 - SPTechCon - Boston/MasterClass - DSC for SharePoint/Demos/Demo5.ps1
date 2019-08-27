Configuration Demo5
{
    param (
        [parameter(Mandatory = $true)]         
        [System.Int32] 
        $NumberOfInstances
    )
    Import-DSCResource -ModuleName NetworkingDSC -ModuleVersion 7.3.0.0
    Node localhost
    {
        for ($i = 0; $i -lt $NumberOfInstances; $i++)
        {
            $RuleName = "MyRule$i"
            FireWall $RuleName
            {
                Name        = $RuleName
                LocalPort   = (700 + $i)
                DisplayName = $RuleName
                Group       = "Demo2"
                Ensure      = 'Present'
                Enabled     = 'True'
                Profile     = ('Domain', 'Private')
                Direction   = "Inbound"
                Protocol    = "TCP"
            }
        }
    }
}