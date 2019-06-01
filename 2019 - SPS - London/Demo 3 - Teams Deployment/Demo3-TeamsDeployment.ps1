Configuration Demo3
{
    Import-DscResource -ModuleName Office365DSC
    $Creds = Get-Credential
    Node localhost
    {
        TeamsTeam SPSLondon
        {
            DisplayName             = "SPS London"
            AllowGiphy              = $true
            AllowUserDeleteMessages = $true
            GlobalAdminAccount      = $Creds
            Ensure                  = "Present"
        }

        TeamsChannel UserFeedback
        {
            TeamName           = "SPS London"
            DisplayName        = "Feedback"
            Description        = "Channel to capture feedback"
            GlobalAdminAccount = $Creds
            DependsOn          = "[TeamsTeam]SPSLondon"            
            Ensure             = "Present"
        }

	    TeamsChannel Sessions
        {
            TeamName           = "SPS London"
            DisplayName        = "Sessions"
            Description        = "Channel to capture information about sessions"
            GlobalAdminAccount = $Creds
            DependsOn          = "[TeamsTeam]SPSLondon"            
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
Demo3 -ConfigurationData $configData