$directoryString = Read-Host -Prompt "`nEnter the directory path where the python virtual environment will be installed"
$directory = Get-Item $directoryString
$name = Read-Host -Prompt "Enter the name of the python virtual environment"
if(Test-Path -Path "$directory\$name" -PathType Container) {
  "A folder already exists in that directory with that name.`n"
} else {
  $where = where.exe Python
  $number = 0
  "`nThe installed python.exe versions:`n"
  while ( $where[$number] ) {
    $current = $where[$number]
    "    $number.   $current"
    $number = $number + 1
  }
  $version = Read-Host -Prompt "`nEnter the list number of the python.exe you would like to use"
  $python = $where[$version]
  "`nThe python virtual environment is being created...`n"
  Invoke-Expression "virtualenv --python $python $directory\$name"
  if($?) {
    while($true) {
      $libraries = Read-Host -Prompt "`nEnter the name of a library you would like to install (press Enter to skip)"
      if($libraries -ne '') {
        Invoke-Expression "$directory\$name\Scripts\activate.ps1"
        Invoke-Expression "py -m pip install $libraries"
        Invoke-Expression 'deactivate'
      }
      else {
        break
      }
    }
    $activate = Read-Host -Prompt "`nDo you want to activate the python venv? (y/n) "
    if ($activate -eq 'y') {
      Invoke-Expression "$directory\$name\Scripts\activate.ps1"
    } elseif ($activate -eq 'n') {
      "The python venv will not be activated."
    }
    else {
      "You did not enter a valid answer. The python venv will not be activated."
    }
    "`nThe python virtualenv creation is complete.`n`nTo activate the python virtualenv: $directory\$name\Scripts\activate.ps1`n"
  } else {
    "`nThe python virtual environment could not be created.`n"
  }
}
