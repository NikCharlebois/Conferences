Configuration FileManagement
{
	File Folder
    {
        DestinationPath = "C:\Demo1"
        Type            = "Directory"
        Ensure          = "Present"
    }

    File FileA
    {
        DestinationPath = "C:\Demo1\FileA.txt"
        Contents        = "Hello Folks. This is the content of FileA"
        Ensure          = "Present"
        DependsOn       = "[File]Folder"
    }

    File FileB
    {
        DestinationPath = "C:\Demo1\FileB.txt"
        Contents        = "Hello Folks. This is the content of FileB"
        Ensure          = "Present"
        DependsOn       = "[File]Folder"
    }
}

FileManagement
Start-DscConfiguration FileManagement -Wait -Verbose -Force