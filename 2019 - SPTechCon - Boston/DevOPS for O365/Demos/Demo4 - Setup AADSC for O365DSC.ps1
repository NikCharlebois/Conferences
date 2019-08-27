$Dependencies = @(
   @{ModuleName = "ReverseDSC"; RequiredVersion = "1.9.4.4"; }, 
   @{ModuleName = "MSOnline"; RequiredVersion = "1.1.183.17"; },
   @{ModuleName = "SharePointPnPPowerShellOnline"; RequiredVersion = "3.12.1908.1"; },
   @{ModuleName = "Microsoft.Online.SharePoint.PowerShell"; RequiredVersion = "16.0.8316.0"; },
   @{ModuleName = "MicrosoftTeams"; RequiredVersion = "1.0.0"; },
   @{ModuleName = "AzureAD"; RequiredVersion = "2.0.2.4"; },
   @{ModuleName = "MSCloudLoginAssistant"; RequiredVersion = "0.6"; },
   @{ModuleName = "Office365DSC"; RequiredVersion = "1.0.0.846"; }
)

foreach($dep in $Dependencies)
{
    $galleryRepoUri = "https://www.powershellgallery.com/api/v2/package/" + $dep.ModuleName + "/" + $dep.RequiredVersion
    $galleryRepoUri
    New-AzureRmAutomationModule -ResourceGroupName 'TBD2' -AutomationAccountName 'DevOPS' -Name $dep.ModuleName -ContentLink $galleryRepoUri
}