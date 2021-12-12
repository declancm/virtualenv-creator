$setAlias = Read-Host -Prompt "`nWould you like to add an alias to PowerShell? (y/n)"
if ($setAlias -eq 'y') {
  $location = Write-Output $profile
  if (!(Test-Path $location)) { New-Item -path ~\Documents\WindowsPowerShell -name Microsoft.PowerShell_profile.ps1 -type "file" }
  if (Select-String -Path $location -Pattern "Set-Alias pyvenv runPyvenv" -SimpleMatch -Quiet) {
    "The alias has already been added to PowerShell.`n"
  }
  else {
    Add-Content $location "`nfunction runPyvenv { Invoke-Expression `". ~\Documents\virtualenv-creator\pyvenv.ps1`" }`nSet-Alias pyvenv runPyvenv"
    "The alias was added.`n"
  }
}
else {
  "An alias was not added.`n"
}
