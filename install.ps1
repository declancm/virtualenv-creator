$setAlias = Read-Host -Prompt "`nWould you like to add an alias to PowerShell? (y/n)"
if ($setAlias -eq 'y') {
  $location = Write-Output $profile
  $alias = [Regex]::Escape("function runPyvenv { Invoke-Expression `". ~\Documents\virtualenv-creator\pyvenv.ps1`" }`nSet-Alias pyvenv runPyvenv")
  #$alias = Select-String -Path $location -Pattern [Regex]::Escape("function runPyvenv { Invoke-Expression `". ~\Documents\virtualenv-creator\pyvenv.ps1`" }`nSet-Alias pyvenv runPyvenv")
  #if ($null -ne $alias) {
  if (Get-Content $location | ForEach-Object{$_ -match $alias}) {
    "The alias has already been added to PowerShell.`n"
  }
  else {
    Add-Content $location "`n$alias"
  }
}
else {
  "An alias was not added.`n"
}
