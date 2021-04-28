Export-M365DSCConfiguration -Quiet -GlobalAdminAccount $Global:AdminNonMFA `
    -Path 'C:\Demos\3-Export' `
    -FileName "DemoExport.ps1" `
    -ComponentsToExtract @('AADGroupsNamingPolicy', 'SPOSharingSettings')

explorer "C:\Demos\3-Export\DemoExport.ps1"