# Navigate to path where the export from Demo 3 was stored;
cd C:\dsc

# Compile the configuration with the TARGET tenant's credentials;
./Demo2Export.ps1 -GlobalAdminAccount $Global:Target

# Deploy the configuration onto the TARGET tenant;
Start-DscConfiguration Demo2Export -Wait -Verbose -Force