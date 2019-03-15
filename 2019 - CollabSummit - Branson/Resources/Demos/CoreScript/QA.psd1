@{
    AllNodes = @(
        @{
            NodeName        = "SPWFENACS-QA"
            RunCentralAdmin = $true
            ServerRole      = "WebFrontEndWithDistributedCache"
        },
        @{
            NodeName        = "SPAPPNACS-QA"
            RunCentralAdmin = $false
            ServerRole      = "Application"
        },
        @{
            NodeName        = "SPSEARCHNACS-QA"
            RunCentralAdmin = $false
            ServerRole      = "Search"
        }
    )
    Environment = @{
        Domain         = "contoso.qa"
        DatabaseServer = "SPSQLNACS-QA"
    }
}
