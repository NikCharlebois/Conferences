Configuration Blueprint
{
    param (
        [parameter()]
        [System.Management.Automation.PSCredential]
        $GlobalAdminAccount
    )

    $OrganizationName = $Credsglobaladmin.UserName.Split('@')[1]
    Import-DscResource -ModuleName 'Microsoft365DSC' -ModuleVersion '1.21.421.2'

    Node localhost
    {
        SPOSharingSettings SPORule1
        {
            IsSingleInstance = 'Yes'
            SharingCapability = "Disabled" ### L1|<img src='https://openclipart.org/image/2400px/svg_to_png/29833/warning.png' width='30px' />Please ensure external sharing is disabled to ensure we're not exposing the organization to documents leak.
            DefaultSharingLinkType = 'None' ### L2|We recommend turning off the sharing link feature. For more information, please refer to <a href="https://docs.microsoft.com">Microsoft official documentation</a>.
        }
    }
}