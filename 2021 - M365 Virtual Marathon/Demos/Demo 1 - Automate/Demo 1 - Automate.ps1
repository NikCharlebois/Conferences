#region Header
Configuration M365TenantConfig
{
    Import-DscResource -ModuleName Microsoft365DSC
    $GlobalAdminAccount = Get-Credential
    Node localhost
    {
#endregion
        SCSensitivityLabel LicensePlateInfo
        {
            DisplayName          = "License Plate Info";
            Ensure               = "Present";
            GlobalAdminAccount   = $GlobalAdminAccount;
            LocaleSettings       = @(
                MSFT_SCLabelLocaleSettings
                {
                    LocaleKey = 'DisplayName'
                    Settings  = @(
                        MSFT_SCLabelSetting
                        {
                            Key   = 'en-us'
                            Value = 'License Plate Info'
                        }
                        MSFT_SCLabelSetting
                        {
                            Key   = 'fr-ca'
                            Value = 'Information de plaque immatriculation'
                        }
                    )
                }
            );
            Name                 = "LicensePlateInfo";
        }

        SPOSharingSettings TenantSharingSettings
        {
            DefaultSharingLinkType                     = "Internal";
            EnableGuestSignInAcceleration              = $False;
            FileAnonymousLinkType                      = "Edit";
            FolderAnonymousLinkType                    = "Edit";
            IsSingleInstance                           = "Yes";
            RequireAcceptingAccountMatchInvitedAccount = $True;
            SharingCapability                          = "ExistingExternalUserSharingOnly";
            GlobalAdminAccount                         = $GlobalAdminAccount
        }

        TeamsCallingPolicy AutomateDemoPolicy
        {
            AllowCallForwardingToPhone = $False;
            AllowCallForwardingToUser  = $True;
            AllowCallGroups            = $False;
            AllowDelegation            = $True;
            AllowPrivateCalling        = $False;
            AllowVoicemail             = "UserOverride";
            BusyOnBusyEnabledType      = "Disabled";
            Ensure                     = "Present";
            GlobalAdminAccount         = $GlobalAdminAccount;
            Identity                   = "Automate Demo Policy";
            PreventTollBypass          = $True;
        }

#region Footer
    }
}

$ConfigData = @{
    AllNodes = @(
        @{
            NodeName                    = 'localhost'
            PSDscAllowPlainTextPassword = $true;
            PSDscAllowDomainUser        = $true;
        }
    )
}
cd 'C:\GitHub\Conferences\2020 - M365 Virtual Marathon\Demos\Demo 1 - Automate'
M365TenantConfig -ConfigurationData $ConfigData | Out-Null
Start-DSCConfiguration M365TenantConfig -Wait -Verbose -Force
#endregion