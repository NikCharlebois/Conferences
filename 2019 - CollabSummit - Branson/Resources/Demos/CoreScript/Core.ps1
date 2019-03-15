Configuration Core
{
    $CredsSPSetup = Get-AutomationPSCredential -Name SPSetup
    $CredsSPFarm  = Get-AutomationPSCredential -Name SPFarm
    Import-DSCResource -ModuleName SharePointDSC -ModuleVersion 3.2.0.0

    Node $AllNodes.NodeName
    {
        SPFarm Farm
        {
            IsSingleInstance          = "Yes"
            FarmConfigDatabaseName    = "SP_Config"
            AdminContentDatabaseName  = "SP_Admin"
            DatabaseServer            = $ConfigurationData.Environment.DatabaseServer
            FarmAccount               = $CredsSPFarm
            Passphrase                = $CredsSPFarm
            RunCentralAdmin           = $Node.RunCentralAdmin
            CentralAdministrationPort = 7777
            ServerRole                = $Node.ServerRole
            PsDscRunAsCredential      = $CredsSPSetup
            Ensure                    = "Present"
        }

        if ($Node.RunCentralAdmin)
        {
            #region WebApplication
            SPWebApplication Root
            {
                Name                   = "Root WebApp"
                ApplicationPool        = "SharePoint - 80"
                ApplicationPoolAccount = $CredsSPFarm.UserName
                WebAppUrl              = "http://collabsummit." + $ConfigurationData.Environment.Domain
                HostHeader             = "CollabSummit." + $ConfigurationData.Environment.Domain
                PsDscRunAsCredential   = $CredsSPSetup
                Ensure                 = "Present"
            }

            SPWebAppBlockedFileTypes BlockedFiles
            {
                WebAppUrl              = "http://collabsummit." + $ConfigurationData.Environment.Domain
                EnsureBlocked          = @("ashx", "json", "exe")
                EnsureAllowed          = @()
                PsDscRunAsCredential   = $CredsSPSetup
            }
            #endregion

            #region Site Collections
            SPSite RootSite
            {
                Url                  = "http://collabsummit." + $ConfigurationData.Environment.Domain
                Name                 = "Root Site Collection"
                OwnerAlias           = "contoso\NikCharlebois"
                Template             = "STS#0"
                PsDscRunAsCredential = $CredsSPSetup
            }

            SPSite HumanResources
            {
                Url                      = "http://HumanResources." + $ConfigurationData.Environment.Domain
                Name                     = "Human Resources"
                OwnerAlias               = "contoso\NikCharlebois"
                Template                 = "STS#0"
                HostHeaderWebApplication = "http://collabsummit." + $ConfigurationData.Environment.Domain
                PsDscRunAsCredential     = $CredsSPSetup
            }

            #region Search
            SPSearchServiceApp SearchServiceApplication
            {
                WindowsServiceAccount       = $CredsSPFarm
                Ensure                      = "Present"
                PsDscRunAsCredential        = $CredsSPFarm
                ProxyName                   = "Search Service Application"
                ApplicationPool             = "Search Query"
                DatabaseName                = "Search_Service_Application_DB"
                Name                        = "Search Service Application"
                DefaultContentAccessAccount = $CredsSPFarm
                DatabaseServer              = $ConfigurationData.Environment.DatabaseServer
            }
            #endregion
        }
    }
}