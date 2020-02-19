Configuration Demo1
{
    User Nik
    {
        UserName = "Nik.Charlebois"
        FullName = "Nik Charlebois"
    }

    User Bob
    {
        UserName = "Bob.Houle"
        FullName = "Bob.Houle"
    }
}

Demo1
Start-DSCConfiguration Demo1 -Wait -Verbose -Force