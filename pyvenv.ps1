$directoryString = Read-Host -Prompt "`nEnter the directory path where the python virtualenv will be installed"
$directory = Get-Item $directoryString
$name = Read-Host -Prompt "Enter the name of the python virtualenv"
if(Test-Path -Path "$directory\$name" -PathType Container) {
  "A folder already exists in that directory with that name.`n"
} else {
  "`nThe python virtualenv is being created...`n"
  Invoke-Expression "py -m venv $directory\$name"
  if($?) {
    $libraries = Read-Host -Prompt "Do you want to install pandas and matplotlib? (y/n) "
    if($libraries -eq 'y') {
      Invoke-Expression "$directory\$name\Scripts\activate.ps1"
      Invoke-Expression 'py -m pip install pandas'
      Invoke-Expression 'py -m pip install matplotlib'
      Invoke-Expression 'deactivate'
    } elseif($libraries -eq 'n') {
      "Libraries will not be installed.`n"
    } else {
      "You did not enter a valid answer. Libraries will not be installed.`n"
    }
    # "`nTo activate the python venv: $directory\$name\Scripts\activate.ps1`n"
    $activate = Read-Host -Prompt "Do you want to activate the python virtualenv? (y/n) "
    if ($activate -eq 'y') {
      Invoke-Expression "$directory\$name\Scripts\activate.ps1"
    } elseif ($activate -eq 'n') {
      "The python virtualenv will not be activated.`n"
      "To activate the python virtualenv: $directory\$name\Scripts\activate.ps1"
    }
    else {
      "You did not enter a valid answer. The python virtualenv will not be activated.`n"
      "To activate the python virtualenv: $directory\$name\Scripts\activate.ps1"
    }
    "`nThe python virtualenv is created.`n"
  } else {
    "`nThe python virtualenv could not be created.`n"
  }
}
