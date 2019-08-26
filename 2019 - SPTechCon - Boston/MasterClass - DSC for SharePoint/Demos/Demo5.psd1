@{
    AllNodes = @(
        @{
            NodeName                    = "SPWFETBD2"
            IsMaster                    = $true
            PSDSCAllowPlaintextPassword = $true
            ServerRole                  = "WebFrontEnd"
            RunCentralAdmin             = $true
        },
        @{
            NodeName                    = "SPAppTBD2"
            IsMaster                    = $false
            PSDSCAllowPlaintextPassword = $true
            ServerRole                  = "Application"
            RunCentralAdmin             = $false
        },
        @{
            NodeName                    = "SPSearchTBD2"
            IsMaster                    = $false
            PSDSCAllowPlaintextPassword = $true
            ServerRole                  = "WebFrontEnd"
            RunCentralAdmin             = $false
        }
    )

    Settings = @{
        DatabaseServer = "SPSQLTBD2"
    }
}
