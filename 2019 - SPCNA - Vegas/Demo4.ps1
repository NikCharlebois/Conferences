Configuration MyTenant
{
    Import-DscResource -ModuleName Office365DSC
    $Creds = Get-Credential
    Node localhost
    {
        TeamsTeam BRK169Demo
        {
            DisplayName             = "BRK169 - Demo"
            AllowGiphy              = $true
            AllowUserDeleteMessages = $true
            GlobalAdminAccount      = $Creds
            Ensure                  = "Present"
        }

        TeamsChannel UserFeedback
        {
            TeamName           = "BRK169 - Demo"
            DisplayName        = "Feedback"
            Description        = "Channel to capture feedback"
            GlobalAdminAccount = $Creds
            DependsOn          = "[TeamsTeam]BRK169Demo"            
            Ensure             = "Present"
        }
    }
}

$configData = @{
    AllNodes = @(
        @{
            NodeName = "localhost"
            PSDSCAllowPlaintextPassword = $true
        }
    )
}
MyTenant -ConfigurationData $configData