Configuration SPDemoTenant
{
    param (
        [parameter(Mandatory = $true)]         
        [System.String]
        $GlobalAdminAccount,

        [parameter(Mandatory = $true)]         
        [System.String]
        $NodeName,

        [parameter(Mandatory = $true)]         
        [System.String]
        $DomainName
    )
    Import-DscResource -ModuleName Office365DSC
    $Creds = Get-AutomationPSCredential -Name $GlobalAdminAccount
    Node $NodeName
    {
        #region Users
        O365User Nik
        {
            UserPrincipalName  = "Nik.Charlebois@$($DomainName)"
            DisplayName        = "Nik Charlebois"
            GlobalAdminAccount = $Creds
        }

        O365User Brian
        {
            UserPrincipalName  = "Brian.Lalancette@$($DomainName)"
            DisplayName        = "Brian Lalancette"
            GlobalAdminAccount = $Creds
        }
        #endregion
        
        #region Site Collections
        SPOSite HumanResources
        {
            Url                = "https://$($DomainName.Split('.')[0]).sharepoint.com/sites/HR"
            CentralAdminUrl    = "https://$($DomainName.Split('.')[0])-admin.sharepoint.com"
            Template           = "STS#0"
            Owner              = "Nik.Charlebois@$($DomainName)"
            Title              = "Human Resources"
            GlobalAdminAccount = $Creds
        }

        SPOSite Finances
        {
            Url                = "https://$($DomainName.Split('.')[0]).sharepoint.com/sites/Finances"
            CentralAdminUrl    = "https://$($DomainName.Split('.')[0])-admin.sharepoint.com"
            Template           = "STS#0"
            Owner              = "Nik.Charlebois@$($DomainName)"
            Title              = "Finances"
            GlobalAdminAccount = $Creds
        }
        #endregion

        #region Teams
        TeamsTeam WeeklyMeetings
        {
            DisplayName             = "WeeklyMeetings"
            AllowGiphy              = $true
            AllowUserDeleteMessages = $true
            GlobalAdminAccount      = $Creds
            Ensure                  = "Present"
        }

        TeamsChannel Alpha
        {
            TeamName           = "WeeklyMeetings"
            DisplayName        = "Team Alpha"
            GlobalAdminAccount = $Creds
            DependsOn          = "[TeamsTeam]WeeklyMeetings"
            Ensure             = "Present"
        }

        TeamsChannel LT
        {
            TeamName           = "WeeklyMeetings"
            DisplayName        = "Leadership Team"
            GlobalAdminAccount = $Creds
            DependsOn          = "[TeamsTeam]WeeklyMeetings"
            Ensure             = "Present"
        }
        #endregion
    }
}