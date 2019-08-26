Configuration Demo5
{
    Import-DSCResource -ModuleName SharePointDSC -ModuleVersion 3.6.0.0

    #region Credentials
    $SPFarm = Get-Credential -UserName "contoso\SP_farm" -Message "SP_Farm"
    $SPSetup = Get-Credential -UserName "contoso\sp_setup" -Message "SP_Setup"
    #endregion

    Node $AllNodes.NodeName
    {
        SPFarm FarmConfig 
        {
            IsSingleInstance         = "Yes"
            FarmConfigDatabaseName   = "SP_Config"
            DatabaseServer           = $ConfigurationData.Settings.DatabaseServer
            FarmAccount              = $SPFarm
            Passphrase               = $SPFarm
            AdminContentDatabaseName = "SP_AdminContent"
            ServerRole               = $Node.ServerRole
            RunCentralAdmin          = $Node.RunCentralAdmin
            PsDscRunAsCredential     = $SPSetup
            Ensure                   = "Present"
        }

        if ($Node.IsMaster)
        {
            SPServiceAppPool SP80
            {
                Name                 = "SharePoint - 80"
                ServiceAccount       = $SPFarm.UserName
                PsDscRunAsCredential = $SPSetup
                Ensure               = "Present"
                DependsOn            = "[SPFarm]FarmConfig"
            }

            SPWebApplication Root
            {
                Name                   = "Root"
                ApplicationPool        = "SharePoint -80"
                ApplicationPoolAccount = $SPFarm.UserName
                WebAppUrl              = "http://intranet.contoso.com"
                HostHeader             = "intranet.contoso.com"
                PsDscRunAsCredential   = $SPSetup
                Ensure                 = "Present"
                DependsOn              = @("[SPFarm]FarmConfig", "[SPServiceAppPool]SP80")
            }

            SPManagedPath Videos
            {
                WebAppUrl              = "http://intranet.contoso.com"
                RelativeUrl            = "Videos"
                Explicit               = $false
                HostHeader             = $false
                PsDscRunAsCredential   = $SPSetup
                Ensure                 = "Present"
            }
        }
    }
}
$CurrentFolder = split-path $SCRIPT:MyInvocation.MyCommand.Path -parent
Demo5 -ConfigurationData $($CurrentFolder + "\Demo5.psd1")