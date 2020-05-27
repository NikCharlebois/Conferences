$results = Test-DscConfiguration -Detailed
$results.InDesiredState
$results.ResourcesNotInDesiredState