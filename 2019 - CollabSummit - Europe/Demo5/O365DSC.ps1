Configuration MyTenant
{
    Import-DscResource -ModuleName Office365DSC
    $Creds = Get-Credential
    Node localhost
    {
        TeamsTeam CollabSummit
        {
            DisplayName             = "CollabSummit - Demo"
            AllowGiphy              = $true
            AllowUserDeleteMessages = $true
            GlobalAdminAccount      = $Creds
            Ensure                  = "Present"
        }

        TeamsChannel UserFeedback
        {
            TeamName           = "CollabSummit - Demo"
            DisplayName        = "Feedback"
            Description        = "Channel to capture feedback"
            GlobalAdminAccount = $Creds
            DependsOn          = "[TeamsTeam]CollabSummit"            
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