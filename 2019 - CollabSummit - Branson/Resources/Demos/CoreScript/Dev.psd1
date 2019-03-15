@{
    AllNodes = @(
        @{
            NodeName        = "SPWFENACS.contoso.com"
            RunCentralAdmin = $true
            ServerRole      = "WebFrontEndWithDistributedCache"
        },
        @{
            NodeName        = "SPAPPNACS.contoso.com"
            RunCentralAdmin = $false
            ServerRole      = "Application"
        },
        @{
            NodeName        = "SPSEARCHNACS.contoso.com"
            RunCentralAdmin = $false
            ServerRole      = "Search"
        }
    )
    Environment = @{
        DatabaseServer = "SPSQLNACS"
    }
}