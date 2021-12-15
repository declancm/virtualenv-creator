
# Created by Declan Mullen
# Git repository can be found at https://github.com/declancm/virtualenv-creator

$directoryString = Read-Host -Prompt "`nEnter the directory path where the python virtual environment will be installed"
if(Test-Path $directoryString) {
  $directory = Get-Item $directoryString
} else {
  New-Item $directoryString -ItemType Directory | Out-Null
  $directory = Get-Item $directoryString
}
$name = Read-Host -Prompt "Enter the name of the python virtual environment"
if(Test-Path -Path "$directory\$name" -PathType Container) {
  "A folder already exists in that directory with that name.`n"
} else {
  # $where = Get-ChildItem -recursive -include "Python.exe"
  $where = where.exe Python
  $number = 0
  "`nThe installed python.exe versions:`n"
  while (($where[$number]) -and ($where[$number] -ne 'C') ) {
    $current = $where[$number]
    "    $number.   $current"
    $number = $number + 1
  }
  if ($where[$number] -eq 'C') {
    Read-Host -Prompt "    0.   $where`n`nOnly one version of python is installed (press Enter to continue) "
    $python = $where
  } else {
    $version = Read-Host -Prompt "`nEnter the list number of the python.exe you would like to use"
    $python = $where[$version]
  }
  "`nThe python virtual environment is being created..."
  $status = Invoke-Expression "virtualenv --python $python $directory\$name"
  if($status) {
    while($true) {
      $libraries = Read-Host -Prompt "`nEnter the name of a library you would like to install (press Enter to skip) "
      if($libraries -ne '') {
        Invoke-Expression "$directory\$name\Scripts\activate.ps1"
        Invoke-Expression "py -m pip install $libraries"
        Invoke-Expression 'deactivate'
      }
      else {
        break
      }
    }
    $gitignore = Read-Host -Prompt "`nDo you want the virtualenv to be ignored by git? (y/n) "
    if ($gitignore -eq 'y' -or $gitignore -eq 'yes') {
      # Remove-Item -Path $directory\$name\.gitignore -Force -Confirm | Out-Null
      # New-Item -Path $directory\$name -Name .gitignore -Type "file" -Value "*" | Out-Null -and "A .gitignore file was created inside $name."
    } elseif ($gitignore -eq 'n' -or $gitignore -eq 'no') {
      Remove-Item -Path $directory\$name\.gitignore -Force -Confirm:$false | Out-Null
      "The python virtualenv will not be ignored by git."
    } else {
      Remove-Item -Path $directory\$name\.gitignore -Force -Confirm:$false | Out-Null
      "You did not enter a valid answer. The python virtualenv will not be ignored by git."
    }
    $activate = Read-Host -Prompt "`nDo you want to activate the python venv? (y/n) "
    if ($activate -eq 'y' -or $activate -eq 'yes') {
      Invoke-Expression "$directory\$name\Scripts\activate.ps1"
    } elseif ($activate -eq 'n' -or $activate -eq 'no') {
      "The python virtualenv will not be activated."
    } else {
      "You did not enter a valid answer. The python virtualenv will not be activated."
    }
    "`nThe python virtualenv creation is complete.`n`nThe manual activation command:`n$directory\$name\Scripts\activate.ps1`n"
  } else {
    "`nThe python virtual environment could not be created.`n"
  }
}