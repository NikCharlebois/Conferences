# Assert the SOURCE tenant against the K12 Teams Blueprint;
#Assert-M365DSCTemplate -TemplatePath 'C:\github\Conferences\2020 - M365 Virtual Marathon\Demos\Demo 6 - Assess\K12.m365'

# Compare the SOURCE tenant against the TARGET tenant and generate a Delta Report;
cd C:\DSC
New-M365DSCDeltaReport -Source ./FullSource.ps1 -Destination ./FullTarget.ps1 -OutputPath ./Delta.html