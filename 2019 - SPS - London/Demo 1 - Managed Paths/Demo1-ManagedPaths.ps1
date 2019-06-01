Configuration Demo1
{
    Import-DSCResource -ModuleName SharePointDSC -ModuleVersion 3.4.0.0
    $FarmAdmin = Get-Credential -Username "contoso\sp_farm" -Message "Farm Admin Account"
    Node localhost
    {
	SPWebApplication SPSLondon
	{
		Name                   = "SPSLondon"
		Url                    = "https://SPSLondon.contoso.com"
		Port                   = 443
		ApplicationPool        = "SPSLondon"
		ApplicationPoolAccount = $FarmAdmin.UserName
		Ensure                 = "Present"
		PSDscRunAsCredential   = $FarmAdmin
	}
        SPManagedPath VideosMP
        {
            WebAppUrl            = "https://SPSLondon.contoso.com"
            RelativeUrl          = "Videos"
            Explicit             = $false
            HostHeader           = $false
            Ensure               = "Present"
            PSDSCRunAsCredential = $FarmAdmin
        }

        SPManagedPath ArchivesMP
        {
            WebAppUrl            = "https://SPSLondon.contoso.com"
            RelativeUrl          = "Archives"
            Explicit             = $false
            HostHeader           = $false
            Ensure               = "Present"
            PSDSCRunAsCredential = $FarmAdmin
        }
    }
}

$ConfigData = @{
    AllNodes = @(
        @{
            NodeName = "localhost"
            PSDscAllowPlaintextPassword = $true
            PSDscAllowDomainUser = $true
        }
    )
}

Demo1 -ConfigurationData $ConfigData