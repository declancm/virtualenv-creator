$alias = Select-String -Path ~\Documents\File.txt -Pattern "Test"
if ($alias -ne $null)
{
    echo Contains String
}
else
{
    echo Not Contains String
}
