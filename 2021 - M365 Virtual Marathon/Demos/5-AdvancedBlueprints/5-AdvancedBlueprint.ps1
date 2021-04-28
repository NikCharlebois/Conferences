Assert-M365DSCBlueprint -BluePrintUrl "C:\Demos\5-AdvancedBlueprints\Blueprint.ps1" `
    -OutputReportPath 'C:\Demos\5-AdvancedBlueprints\Report.html' `
    -Credentials $Global:AdminnonMFA `
    -HeaderFilePath "C:\Demos\5-AdvancedBlueprints\ContosoHeader.html"