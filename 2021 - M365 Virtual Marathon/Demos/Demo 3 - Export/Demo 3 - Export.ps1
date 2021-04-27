# Launch the Export feature using the interactive GUI;
Export-M365DSCConfiguration

# Initiate an unattended export of the TeamsCallingPolicy and TeamsMeetingPolicy of the SOURCE tenant;
Export-M365DSCConfiguration -Quiet -GlobalAdminAccount $Global:Source `
                            -ComponentsToExtract @("TeamsCallingPolicy", "TeamsMeetingPolicy") `
                            -Path C:\dsc `
                            -FileName "Demo2Export.ps1"