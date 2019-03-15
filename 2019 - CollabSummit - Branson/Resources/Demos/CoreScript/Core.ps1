Configuration Core
{
    $CredsSPSetup = Get-AutomationPSCredential -Name SPSetup
    $CredsSPFarm  = Get-AutomationPSCredential -Name SPFarm
    Import-DSCResource -ModuleName SharePointDSC -ModuleVersion 3.2.0.0
    
    Node $AllNodes.NodeName
    {
        SPFarm Farm
        {
            IsSingleInstance         = "Yes"
            FarmConfigDatabaseName   = "SP_Config"
            AdminContentDatabaseName = "SP_Admin"
            DatabaseServer           = $ConfigurationData.Environment.DatabaseServer
            FarmAccount              = $CredsSPFarm
            Passphrase               = $CredsSPFarm
            RunCentralAdmin          = $Node.RunCentralAdmin
            ServerRole               = $Node.ServerRole
            PsDscRunAsCredential     = $CredsSPSetup
            Ensure                   = "Present"
        }
    }
}