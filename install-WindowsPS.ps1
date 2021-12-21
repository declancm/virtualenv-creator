$setAlias = Read-Host -Prompt "`nWould you like to add an alias to PowerShell? (y/n)"
if ($setAlias -eq 'y' -or $setAlias -eq 'yes') {
    $location = Write-Output $profile
    if (Test-Path $location) {
        if (Select-String -Path $location -Pattern "Set-Alias pyvenv runPyvenv" -SimpleMatch -Quiet) {
            "The alias has already been added to PowerShell.`n"
        } else {
            Add-Content $location "`nfunction runPyvenv { Invoke-Expression `"PowerShell.exe /nologo -ExecutionPolicy Bypass -NoExit -File $HOME\Documents\virtualenv-creator\pyvenv-PS.ps1`" }`nSet-Alias pyvenv runPyvenv"
            "The alias was added. Please restart PowerShell for the alias to take effect.`n"
        }
    } else {
        New-Item -Path $location -Type File -Force -Value "function runPyvenv { Invoke-Expression `"PowerShell.exe /nologo -ExecutionPolicy Bypass -NoExit -File $HOME\Documents\virtualenv-creator\pyvenv-PS.ps1`" }`nSet-Alias pyvenv runPyvenv" | Out-Null
        "The profile.ps1 file was created and the alias was added. Please restart PowerShell for the alias to take effect.`n"
    }
} else {
    "An alias was not added.`n"
}
