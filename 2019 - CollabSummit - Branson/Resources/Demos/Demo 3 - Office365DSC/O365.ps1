Configuration O365
{
    Import-DscResource -ModuleName Office365DSC
    $GlobalAdmin = Get-Credential -UserName "admin@office365dsc.onmicrosoft.com" -Message "Global Admin Creds"
    
    Node localhost
    {
        #region SharePoint Online
        SPOSite CollabSummit
        {
            Url                = "https://office365dsc.sharepoint.com/sites/CollabSummit"
            Title              = "CollaborationSummit"
            Owner              = "admin@Office365DSC.onmicrosoft.com"
            StorageQuota       = 100
            CentralAdminUrl    = "https://office365dsc-admin.sharepoint.com"
            GlobalAdminAccount = $GlobalAdmin
            Ensure             = "Present"
        }
        #endregion

        #region Teams
        TeamsTeam CollabSummit
        {
            DisplayName        = "Collab Summit"
            Description        = "This is me demoing the Teams Resource"
            GlobalAdminAccount = $GlobalAdmin
            Ensure             = "Present"
        }

        TeamsChannel DSCChannel
        {
            TeamName           = "Collab Summit"
            DisplayName        = "DSC Discussions"
            GlobalAdminAccount = $GlobalAdmin
            Ensure             = "Present"
        }
        #endregion
    }
}

$ConfigData = @{
    AllNodes = @(
        @{
            NodeName                    = "localhost"
            PsDSCAllowPlaintextPassword = $true
        }
    )
}

O365 -ConfigurationData $ConfigData
Start-DscConfiguration O365 -Wait -Verbose -Force