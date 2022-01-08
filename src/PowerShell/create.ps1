# Created by Declan Mullen
# Git repository can be found at git://github.com/declancm/virtualenv-creator

function Remove-VenvPaths {
  param (
    [Parameter(Mandatory = $true, Position = 0)] [Object]$array
  )


}
function Enable-Create {
  param (
    [Parameter(Mandatory = $true, Position = 0)] [Object]$ProjectPath
  )

  $virtualenvList = Join-Path -Path $ProjectPath -ChildPath '\data\Powershell\virtualenvList.txt'

  $directoryString = Read-Host -Prompt "`nEnter the directory path where the python virtual environment will be installed"
  if(Test-Path $directoryString) {
    $directory = Get-Item $directoryString
  } else {
    New-Item $directoryString -ItemType Directory | Out-Null
    $directory = Get-Item $directoryString
  }
  $name = Read-Host -Prompt "Enter the name of the python virtual environment"
  if(Test-Path -Path "$directory\$name" -PathType Container) {
    "`nError: A folder already exists in that directory with that name.`n"
  } else {
    # $where = Get-ChildItem -recursive -include "Python.exe"

    # ignore exe with \Scripts\python.exe
    # $where = @(where.exe Python)

    [System.Collections.ArrayList]$where = @(where.exe Python)
    $n = $where.Count - 1
    $currentLine = $where[$n]
    while ($Null -ne $currentLine) {
      #delete line if it doesn't exist
      if ($currentLine.Contains('\Scripts\python.exe')) {
        $where.Remove($n)
      }
      $n--
      $currentLine = $where[$n]
    }

    $number = 0
    $numberPlus = 1
    "`nThe installed python.exe versions:`n"
    while (($where[$number]) -and ($where[$number] -ne 'C') ) {
      $current = $where[$number]
      "    $numberPlus.   $current"
      $number = $number + 1
      $numberPlus = $numberPlus + 1
    }
    if ($where[$number] -eq 'C') {
      Read-Host -Prompt "    1.   $where`n`nOnly one version of python is installed (press Enter to continue)"
      $python = $where
    } else {
      $versionPlus = Read-Host -Prompt "`nEnter the list number of the python.exe you would like to use"
      $version = $versionPlus - 1
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
      $librariestxt = Join-Path $ProjectPath '\libraries.txt'
      if (Test-Path -Path $librariestxt -PathType Leaf) {
        # check condition that the file is empty
        $installLibraries = Read-Host -Prompt "`n A libraries.txt file was found. Do you want to install the contents into the virtualenv? (y/n)"
        if ($installLibries -eq 'y'){
          if ($Null -eq (Get-Content -Path $virtualenvList)) {
          }
          else {
            [string[]]$libraries = Get-Content -Path $virtualenvList
            $currentLine = $libraries[0]
            $n = 0
            Invoke-Expression "$directory\$name\Scripts\activate.ps1"
            "`nThe libaries.txt is being installed ...`n"
            while($Null -ne $currentLine) {
              py -m pip -q install $library
              if ($?) {
                "The pip library '$currentLibrary' was installed successfully."
              } else {
                "Error: The pip library '$currentLibrary' could not be installed."
              }
              $n++
              $currentLine = $libraries[$n]
            }
            Invoke-Expression 'deactivate'
            "`nThe libraries.txt was installed."
          }
        }
        elseif ($installLibraries -eq 'n') {
          "The libraries.txt will not be installed."
        }
        else {
          "`nError: You did not enter a valid input. The libraries.txt will not be installed."
        }
      }
      while($true) {
        $library = Read-Host -Prompt "`nEnter the name of a pip library you would like to install (press Enter to skip)"
        if ($library -ne '') {
          Invoke-Expression "$directory\$name\Scripts\activate.ps1"
          "`nThe pip library is being installed ...`n"
          py -m pip -q install $library
          if ($?) {
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
      $gitignore = Read-Host -Prompt "`nDo you want the virtualenv to be ignored by git? (y/n)"
      if ($gitignore -eq 'y' -or $gitignore -eq 'yes') {
        # Remove-Item -Path $directory\$name\.gitignore -Force -Confirm | Out-Null
        # New-Item -Path $directory\$name -Name .gitignore -Type "file" -Value "*" | Out-Null -and "A .gitignore file was created inside $name."
      } elseif ($gitignore -eq 'n' -or $gitignore -eq 'no') {
        Remove-Item -Path $directory\$name\.gitignore -Force -Confirm:$false | Out-Null
        "The python virtualenv will not be ignored by git."
      } else {
        Remove-Item -Path $directory\$name\.gitignore -Force -Confirm:$false | Out-Null
        "You did not enter a valid input. The python virtualenv will not be ignored by git."
      }
      $activate = Read-Host -Prompt "`nDo you want to activate the python venv? (y/n)"
      if ($activate -eq 'y' -or $activate -eq 'yes') {
        Invoke-Expression "$directory\$name\Scripts\activate.ps1"
      } elseif ($activate -eq 'n' -or $activate -eq 'no') {
        "The python virtualenv will not be activated."
      } else {
        "You did not enter a valid input. The python virtualenv will not be activated."
      }
      "`nThe python virtualenv creation is complete.`n"
      # "The manual activation command:`n$directory\$name\Scripts\activate.ps1`n"
    } else {
      "`nError: The python virtual environment could not be created.`n"
    }
  }
}
