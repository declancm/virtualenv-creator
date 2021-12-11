$setAlias = Read-Host -Prompt "`nWould you like to add an alias to PowerShell? (y/n)"
if ($setAlias -eq 'y') {
  $location = Write-Output $profile
  $alias = "`nfunction runPyvenv { Invoke-Expression `". ~\Documents\virtualenv-creator\pyvenv.ps1`" }`nSet-Alias pyvenv runPyvenv"
  if (Select-String -Path $location -Pattern $alias -SimpleMatch -Quiet) {
    "The alias has already been added to PowerShell.`n"
  }
  else {
    Add-Content $location "`n$alias"
    "The alias was added.`n"
  }
}
else {
  "An alias was not added.`n"
}
