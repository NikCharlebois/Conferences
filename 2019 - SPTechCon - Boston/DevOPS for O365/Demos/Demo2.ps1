Configuration Demo2
{
    Import-DSCResource -ModuleName Office365DSC
    $GA = Get-Credential -Username "admin@SPTCDevOPS11.onmicrosoft.com" -Message "GA"
    
    Node localhost
    {
        O365User JohnSmith
        {
            UserPrincipalName  = "John.Smith@SPTCDevOPS11.onmicrosoft.com"
            DisplayName        = "John Smith"
            City               = "Boston"
            Office             = "Head Office"
            PhoneNumber        = "555-555-5555"
            GlobalAdminAccount = $GA
            Ensure             = "Present"
        }

        O365User BobHoule
        {
            UserPrincipalName  = "Bob.Houle@SPTCDevOPS11.onmicrosoft.com"
            DisplayName        = "Bob Houle"
            City               = "Gatineau"
            Office             = "Ottawa"
            PhoneNumber        = "555-555-5556"
            GlobalAdminAccount = $GA
            Ensure             = "Present"
        }

        SPOSearchManagedProperty Feedback
        {
            Name               = "Feedback"
            Type               = "Text"
            GlobalAdminAccount = $GA
            Ensure             = "Present"
        }

        TeamsTeam SPTechCon
        {
            DisplayName          = "SPTechCon"
            AllowGiphy           = $false
            AllowChannelMentions = $false
            GlobalAdminAccount   = $GA
            Ensure               = "Present"
        }
    }
}

$ConfigData = @{
    AllNodes = @(
        @{
            NodeName = "localhost"
            PSDscAllowPlainTextPassword = $true
        }
    )
}

cd \Demo2
Demo2 -ConfigurationData $ConfigData
Start-DscConfiguration Demo2 -Wait -Verbose -Force