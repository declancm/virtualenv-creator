$setAlias = Read-Host -Prompt "`nWould you like to add an alias to PowerShell? (y/n)"
if ($setAlias -eq 'y') {
  $location = Invoke-Expression "echo $profile"
  $alias = Select-String -Path $location -Pattern "function runPyvenv { Invoke-Expression `". ~\Documents\virtualenv-creator\pyvenv.ps1`" }`nSet-Alias pyvenv runPyvenv"
  if ($alias -ne $null) {
    "The alias has already been added to PowerShell."
  }
  else {
    Add-Content $location "`nfunction runPyvenv { Invoke-Expression `". ~\Documents\virtualenv-creator\pyvenv.ps1`" }`nSet-Alias pyvenv runPyvenv"
  }
}
else {
  "An alias was not added."
}
