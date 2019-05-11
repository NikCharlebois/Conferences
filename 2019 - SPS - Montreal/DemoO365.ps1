Configuration DemoO365
{
    Import-DSCResource -ModuleName Office365DSC
    $GlobalAdmin = Get-Credential
    Node localhost
    {
        TeamsTeam MySUperTeam
        {
            DisplayName = "Mon Super Team"
            GlobalAdminAccount = $GlobalAdmin
            Ensure = "Present"
        }

        TeamsChannel Keynote
        {
            DisplayName = "KeyNote"
            TeamName = "Mon Super Team"
            GlobalAdminAccount = $GlobalAdmin
            Ensure = "Present"
        }
    }
}

$config = @{
    AllNodes = @(
        @{
            NodeName = "localhost"
            PSDscAllowPlainTextPassword = $true
        }
    )
}

DemoO365 -COnfigurationData $config
Start-DSCConfiguration DemoO365 -Wait -Verbose -Force