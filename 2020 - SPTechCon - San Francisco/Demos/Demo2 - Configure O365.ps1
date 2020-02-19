Configuration Demo2
{
    Import-DSCResource -ModuleName Office365DSC
    $GA = Get-Credential -Username "admin@SPTechConWest.onmicrosoft.com" -Message "Global Admin"
    $TenantName = $GA.UserName.Split('@')[1]
    
    Node localhost
    {
        O365User JohnSmith
        {
            UserPrincipalName  = "John.Smith@$TenantName"
            Password           = $GA
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
            Password           = $GA
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

        SPOSharingSettings TenantSharingSettings
        {
            BccExternalSharingInvitations              = $False;
            BccExternalSharingInvitationsList          = $null;
            DefaultLinkPermission                      = "Edit";
            DefaultSharingLinkType                     = "Internal";
            EnableGuestSignInAcceleration              = $False;
            FileAnonymousLinkType                      = "Edit";
            FolderAnonymousLinkType                    = "Edit";
            GlobalAdminAccount                         = $GA;
            IsSingleInstance                           = "Yes";
            NotifyOwnersWhenItemsReshared              = $True;
            PreventExternalUsersFromResharing          = $False;
            ProvisionSharedWithEveryoneFolder          = $False;
            RequireAcceptingAccountMatchInvitedAccount = $True;
            SharingAllowedDomainList                   = $null;
            SharingBlockedDomainList                   = $null;
            SharingCapability                          = "ExistingExternalUserSharingOnly";
            SharingDomainRestrictionMode               = "None";
            ShowAllUsersClaim                          = $False;
            ShowEveryoneClaim                          = $False;
            ShowEveryoneExceptExternalUsersClaim       = $True;
            ShowPeoplePickerSuggestionsForGuestUsers   = $False;
        }

        TeamsTeam SPTechCon
        {
            DisplayName          = "SPTechCon - San Francisco"
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

Demo2 -ConfigurationData $ConfigData
Start-DscConfiguration Demo2 -Wait -Verbose -Force