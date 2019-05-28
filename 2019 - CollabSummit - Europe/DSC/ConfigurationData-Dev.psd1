@{
    AllNodes = @(
        @{
            NodeName = "SPWFECSDev"
            MinRole  = "WebFrontEnd"
        },
        @{
            NodeName = "SPAPPCSDev"
            MinRole  = "Application"
        },
        @{
            NodeName = "SPSRCCSDev"
            MinRole  = "Search"
        }
    )
    Settings = @{
        DomainName     = "contoso.com"
        PrimaryADIP    = "10.0.0.4"
        DatabaseServer = "SPSQLCSDev"
    }
}