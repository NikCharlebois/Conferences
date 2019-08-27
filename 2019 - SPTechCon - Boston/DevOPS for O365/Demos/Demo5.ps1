Configuration Demo5
{
    param (
        [parameter(Mandatory = $true)]
        [System.String] 
        $TenantName
    )

    Import-DSCResource -ModuleName "Office365DSC"
    $GA = Get-AutomationPSCredential -Name "GA$($TenantName)"
    Node localhost
    {
        O365User JohnSmith
        {
            UserPrincipalName  = "John.Smith@$($TenantName).onmicrosoft.com"
            DisplayName        = "John Smith"
            City               = "Boston"
            Office             = "Head Office"
            PhoneNumber        = "555-555-5555"
            GlobalAdminAccount = $GA
            Ensure             = "Present"
        }

        O365User BobHoule
        {
            UserPrincipalName  = "Bob.Houle@$($TenantName).onmicrosoft.com"
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

        TeamsTeam ApplePie
        {
            DisplayName          = "ApplePie"
            AllowGiphy           = $true
            AllowChannelMentions = $false
            GlobalAdminAccount   = $GA
            Ensure               = "Present"
        }
    }
}
