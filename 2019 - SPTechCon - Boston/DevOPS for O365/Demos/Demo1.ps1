Configuration MyFileConfig
{
    File MyFolder
    {
        DestinationPath = "C:\Nik"
	Type = "Directory"
    }
    File File1
    {
        DestinationPath = "c:\Nik\File1.txt"
        Contents = "This is the content of my file"
	DependsOn = "[File]MyFolder"
    }

    File File2
    {
        DestinationPath = "c:\Nik\File2.txt"
        Contents = "This is the content of my file2"
	DependsOn = "[File]MyFolder"
    }
}
MyFileConfig
Start-DSCConfiguration MyFileConfig -Wait -Force -Verbose