# Generated with Microsoft365DSC version 1.21.421.2
# For additional information on how to use Microsoft365DSC, please visit https://aka.ms/M365DSC
param (
    [parameter(Mandatory = $true)]
    [System.String]
    $Keyword
)

Configuration M365TenantConfig
{
    param (
        [parameter()]
        [System.Management.Automation.PSCredential]
        $GlobalAdminAccount,

        [parameter()]
        [System.String]
        $Keyword
    )

    if ($null -eq $GlobalAdminAccount)
    {
        <# Credentials #>
        $Credsglobaladmin = Get-Credential -Message "Global Admin credentials"

    }
    else
    {
        $Credsglobaladmin = $GlobalAdminAccount
    }

    $OrganizationName = $Credsglobaladmin.UserName.Split('@')[1]
    Import-DscResource -ModuleName 'Microsoft365DSC' -ModuleVersion '1.21.421.2'

    Node localhost
    {
        AADApplication 62d61d4f-0f77-402e-96f9-172e04950d3d
        {
            AppId                      = "e97f35bd-1b58-4dbc-9864-ced83c638e52";
            AvailableToOtherTenants    = $False;
            DisplayName                = "App$Keyword";
            Ensure                     = "Present";
            GlobalAdminAccount         = $Credsglobaladmin;
            IdentifierUris             = @();
            KnownClientApplications    = @();
            Oauth2AllowImplicitFlow    = $False;
            Oauth2AllowUrlPathMatching = $False;
            Oauth2RequirePostResponse  = $False;
            ObjectId                   = "43bd9735-e318-44c1-8c33-22de35ab6ab4";
            Permissions                = @(
                MSFT_AADApplicationPermission { 
                    Name                = 'User.Read'
                    Type                = 'Delegated'
                    SourceAPI           = 'Microsoft Graph'
                    AdminConsentGranted = $True
                }
                MSFT_AADApplicationPermission { 
                    Name                = 'User.Read.All'
                    Type                = 'AppOnly'
                    SourceAPI           = 'Microsoft Graph'
                    AdminConsentGranted = $True
                }
            );
            PublicClient               = $False;
            ReplyURLs                  = @();
        }

        EXORemoteDomain 4c18f811-3859-422f-ad4a-4d4816e63eaf
        {
            AllowedOOFType                       = "InternalLegacy";
            AutoForwardEnabled                   = $True;
            AutoReplyEnabled                     = $True;
            ByteEncoderTypeFor7BitCharsets       = "Undefined";
            CharacterSet                         = "";
            ContentType                          = "MimeHtmlText";
            DeliveryReportEnabled                = $True;
            DisplaySenderName                    = $True;
            DomainName                           = "$($Keyword).microsoft365dsc.com";
            Ensure                               = "Present";
            GlobalAdminAccount                   = $Credsglobaladmin;
            Identity                             = "$($Keyword).microsoft365dsc.com";
            IsInternal                           = $True;
            LineWrapSize                         = "Unlimited";
            MeetingForwardNotificationEnabled    = $True;
            Name                                 = "$($Keyword).microsoft365dsc.com";
            NonMimeCharacterSet                  = "";
            PreferredInternetCodePageForShiftJis = "Undefined";
            TargetDeliveryDomain                 = $False;
            TrustedMailInboundEnabled            = $False;
            TrustedMailOutboundEnabled           = $False;
            UseSimpleDisplayName                 = $False;
        }

        TeamsMeetingPolicy b8f89467-4523-49bc-9823-016a470de209
        {
            AllowAnonymousUsersToDialOut               = $False;
            AllowAnonymousUsersToStartMeeting          = $False;
            AllowBreakoutRooms                         = $True;
            AllowChannelMeetingScheduling              = $True;
            AllowCloudRecording                        = $True;
            AllowEngagementReport                      = "Enabled";
            AllowExternalParticipantGiveRequestControl = $False;
            AllowIPAudio                               = $True;
            AllowIPVideo                               = $True;
            AllowMeetingReactions                      = $True;
            AllowMeetNow                               = $True;
            AllowNDIStreaming                          = $False;
            AllowOrganizersToOverrideLobbySettings     = $False;
            AllowOutlookAddIn                          = $True;
            AllowParticipantGiveRequestControl         = $True;
            AllowPowerPointSharing                     = $True;
            AllowPrivateMeetingScheduling              = $True;
            AllowPrivateMeetNow                        = $True;
            AllowPSTNUsersToBypassLobby                = $False;
            AllowRecordingStorageOutsideRegion         = $False;
            AllowSharedNotes                           = $True;
            AllowTranscription                         = $False;
            AllowUserToJoinExternalMeeting             = "Disabled";
            AllowWhiteboard                            = $True;
            AutoAdmittedUsers                          = "EveryoneInCompany";
            DesignatedPresenterRoleMode                = "EveryoneUserOverride";
            EnrollUserOverride                         = "Disabled";
            Ensure                                     = "Present";
            GlobalAdminAccount                         = $Credsglobaladmin;
            Identity                                   = "MeetingPolicy$keyword";
            IPAudioMode                                = "EnabledOutgoingIncoming";
            IPVideoMode                                = "EnabledOutgoingIncoming";
            LiveCaptionsEnabledType                    = "DisabledUserOverride";
            MediaBitRateKb                             = 50000;
            MeetingChatEnabledType                     = "Enabled";
            PreferredMeetingProviderForIslandsMode     = "TeamsAndSfb";
            RecordingStorageMode                       = "Stream";
            ScreenSharingMode                          = "EntireScreen";
            StreamingAttendeeMode                      = "Disabled";
            TeamsCameraFarEndPTZMode                   = "Disabled";
            VideoFiltersMode                           = "AllFilters";
        }
    }
}
M365TenantConfig -ConfigurationData 'C:\Demos\2-Automate\ConfigurationData.psd1' -GlobalAdminAccount $Global:AdminNonMFA -Keyword $Keyword | Out-Null
Start-DSCConfiguration M365TenantConfig -Verbose -Force -Wait