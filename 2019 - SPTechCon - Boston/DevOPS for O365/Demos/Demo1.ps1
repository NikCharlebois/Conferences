Configuration Demo1
{
    Node localhost
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
}

cd \Demo1
Demo1
Start-DscConfiguration Demo1 -Wait -Verbose