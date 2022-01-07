function Enable-Create {
  param (
    [Parameter(Mandatory = $true, Position = 0)] [Object]$ProjectPath
  )

  $virtualenvList = Join-Path -Path $ProjectPath -ChildPath '\data\Powershell\virtualenvList.txt'

  $directoryString = Read-Host -Prompt "`nEnter the directory path where the python virtual environment will be installed: "
  if(Test-Path $directoryString) {
    $directory = Get-Item $directoryString
  } else {
    New-Item $directoryString -ItemType Directory | Out-Null
    $directory = Get-Item $directoryString
  }
  $name = Read-Host -Prompt "Enter the name of the python virtual environment: "
  if(Test-Path -Path "$directory\$name" -PathType Container) {
    "`nError: A folder already exists in that directory with that name.`n"
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
      Read-Host -Prompt "    0.   $where`n`nOnly one version of python is installed (press Enter to continue): "
      $python = $where
    } else {
      $version = Read-Host -Prompt "`nEnter the list number of the python.exe you would like to use:"
      $python = $where[$version]
    }
    $status = Invoke-Expression "virtualenv --python $python $directory\$name"
    if ($status) {
      # if($Null -eq (Get-Content -Path $virtualenvList)) {
      #   Add-Content -Path $virtualenvList -Value "$directory\$name" -Force
      # } else {
      #   Add-Content -Path $virtualenvList -Value "`n$directory\$name" -Force
      # }
      if (-Not (Test-Path -Path $virtualenvList -PathType Leaf)) {
        New-Item -ItemType File -Path $virtualenvList | Out-Null
      }
      $searchString = Select-String -Path $virtualenvList -Pattern "$directory\$name" -SimpleMatch
      if ($null -eq $searchString) {
        Add-Content -Path $virtualenvList -Value "$directory\$name" -Force
      }
      while($true) {
        $library = Read-Host -Prompt "`nEnter the name of a pip library you would like to install (press Enter to skip): "
        if($library -ne '') {
          Invoke-Expression "$directory\$name\Scripts\activate.ps1"
          "`nThe pip library is being installed ...`n"
          py -m pip -q install $library
          if($?) {
            "The pip library '$library' was installed successfully."
          } else {
            "`nError: The pip library '$library' could not be installed."
          }
          Invoke-Expression 'deactivate'
        }
        else {
          break
        }
      }
      $gitignore = Read-Host -Prompt "`nDo you want the virtualenv to be ignored by git? (y/n): "
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
      $activate = Read-Host -Prompt "`nDo you want to activate the python venv? (y/n): "
      if ($activate -eq 'y' -or $activate -eq 'yes') {
        Invoke-Expression "$directory\$name\Scripts\activate.ps1"
      } elseif ($activate -eq 'n' -or $activate -eq 'no') {
        "The python virtualenv will not be activated."
      } else {
        "You did not enter a valid answer. The python virtualenv will not be activated."
      }
      "`nThe python virtualenv creation is complete.`n"
      # "The manual activation command:`n$directory\$name\Scripts\activate.ps1`n"
    } else {
      "`nError: The python virtual environment could not be created.`n"
    }
  }
}
