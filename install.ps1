$alias = Select-String -Path ~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 -Pattern "function runPyvenv { Invoke-Expression `". ~\Documents\virtualenv-creator\pyvenv.ps1`" }`nSet-Alias pyvenv runPyvenv"
if ($alias -ne $null)
{
    "The alias has already been added to PowerShell."
}
else
{
    Add-Content ~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 "`nfunction runPyvenv { Invoke-Expression `". ~\Documents\virtualenv-creator\pyvenv.ps1`" }`nSet-Alias pyvenv runPyvenv"
}
