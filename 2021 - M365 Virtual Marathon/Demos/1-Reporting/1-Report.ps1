$source = "C:\dsc\FullConfig.ps1"
$destinationHTML = "C:\Demos\1-Reporting\Report.html"

New-M365DSCReportFromConfiguration -Type HTML `
    -ConfigurationPath $source `
    -OutputPath $destinationHTML

explorer $destinationHTML