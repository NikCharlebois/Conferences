$parsedData = ConvertTo-DSCObject -Path 'C:\Demos\6-DSCParser\FullConfig.ps1'

# Reporting
$AllTeamsPolicies = $parsedData | Where-Object -FilterScript {$_.ResourceName -like "Teams*Policy"}
$AllTeamsPolicies.ResourceName | Group-Object

# Best Practices Analysis
$ConditionalAccessPolicies= $parsedData | Where-Object -FilterScript {$_.ResourceName -like "AADConditionalAccessPolicy"}
$SPOSharingSettings = $parsedData | Where-Object -FilterScript {$_.ResourceName -eq 'SPOSharingSettings'}

if ($SPOSharingSettings.SharingCapability -eq 'ExternalUserAndGuestSharing' -and $null -eq $ConditionalAccessPolicies)
{
	Write-Warning -Message "We recommend creating at least 1 Conditional Access Policy when sharing SPO files externally"
}