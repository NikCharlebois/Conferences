@{
    AllNodes = @(
        @{
            NodeName        = "SPWFENACS-PROD"
            RunCentralAdmin = $true
            ServerRole      = "WebFrontEndWithDistributedCache"
        },
        @{
            NodeName        = "SPAPPNACS-PROD"
            RunCentralAdmin = $false
            ServerRole      = "Application"
        },
        @{
            NodeName        = "SPSEARCHNACS-PROD"
            RunCentralAdmin = $false
            ServerRole      = "Search"
        }
    )
    Environment = @{
        Domain         = "contoso.com"
        DatabaseServer = "SPSQLNACS-PROD"
    }
}
