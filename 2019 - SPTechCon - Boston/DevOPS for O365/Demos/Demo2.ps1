Configuration Demo2
{
    Import-DSCResource -ModuleName Office365DSC
    $GA = Get-Credential -Username "admin@SPSOttawa2019.onmicrosoft.com" -Message "GA"
    $TenantName = $GA.UserName.Split('@')[1]
    
    Node localhost
    {
        O365User JohnSmith
        {
            UserPrincipalName  = "John.Smith@$TenantName"
            DisplayName        = "John Smith"
            City               = "Boston"
            Office             = "Head Office"
            PhoneNumber        = "555-555-5555"
            GlobalAdminAccount = $GA
            Ensure             = "Present"
        }

        O365User BobHoule
        {
            UserPrincipalName  = "Bob.Houle@$TenantName"
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

        TeamsTeam SPSOttawa
        {
            DisplayName          = "SharePoint Saturday Ottawa"
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