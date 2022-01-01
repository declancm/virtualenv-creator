# Created by Declan Mullen
# Git repository can be found at https://github.com/declancm/virtualenv-creator

$initialInput = Read-Host -Prompt "`nEnter 'c' to create a python virtualenv or 'l' to see a list of created virtualenvs"
if(-Not (Test-Path -Path "$HOME\Documents\virtualenv-creator\data\PowerShell\virtualenvList.txt" -PathType Leaf)) {
  New-Item -ItemType File -Path $HOME\Documents\virtualenv-creator\data\PowerShell\virtualenvList.txt -Force | Out-Null
}
$virtualenvList = Get-Item "$HOME\Documents\virtualenv-creator\data\PowerShell\virtualenvList.txt"
if($initialInput -eq 'c') {
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
      # if($Null -eq (Get-Content -Path $virtualenvList)) {
      #   Add-Content -Path $virtualenvList -Value "$directory\$name" -Force
      # } else {
      #   Add-Content -Path $virtualenvList -Value "`n$directory\$name" -Force
      # }
      Add-Content -Path $virtualenvList -Value "$directory\$name" -Force
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
} elseif($initialInput -eq 'l') {
  while($true) {
    if(Test-Path $virtualenvList) {
      if($Null -eq (Get-Content -Path $virtualenvList)) {
        "`nThe list file is empty. Have you created a virtualenv?"
        ""; Return
      }
    } else {
      "`nA list file does not exit. Have you created a virtualenv?"
        ""; Return
    }
    [string[]]$list = Get-Content -Path $virtualenvList
    $n = $list.Length - 1
    $currentLine = $list[$n]
    while($Null -ne $currentLine) {
      if(-Not (Test-Path $currentLine\Scripts\activate.ps1)) {
        # Set-Content -Path $virtualenvList -Value (Get-Content -Path $virtualenvList | Select-String -Pattern $currentLine)
        $currentLine = [regex]::Escape($currentLine)
        Set-Content -Path $virtualenvList -Value (Get-Content -Path $virtualenvList | Select-String -Pattern $currentLine -NotMatch)
      }
      $script:n--
      $currentLine = $list[$n]
    }
    if($Null -eq (Get-Content -Path $virtualenvList)) {
      "`nThe list file is empty. Have you created a virtualenv?"
      ""; Return
    }
    [string[]]$list = Get-Content -Path $virtualenvList
    "`nA list of your created python virtualenvs :`n"
    $n = 0
    $nPlus = $n + 1
    $currentLine = $list[$n]
    while($Null -ne $currentLine) {
      "    $nPlus.   $currentLine"
      $script:n++
      $script:nPlus++
      $currentLine = $list[$n]
    }
    $inputNumber = Read-Host -Prompt "`nTo select a virtualenv enter the list number (or press Enter to exit) "
    if ($inputNumber -eq '') { ""; Return }
    $number = [int]$inputNumber
    $selectedLine = $list[$number - 1]
    $userInput = Read-Host -Prompt "`nEnter 'a' to activate or 'd' to delete '$selectedLine' (or press Enter to cancel) "
    if($userInput -eq 'a') {
      Invoke-Expression "$selectedLine\Scripts\activate.ps1"
      "The virtualenv was activated."
    }
    elseif($userInput -eq 'd') {
      $delete = Read-Host -Prompt "Are you sure you want to delete '$selectedLine'? (y/n) "
      if($delete -eq 'y') {
        Remove-Item -Path $selectedLine -Force -Recursive | Out-Null
        "The virtualenv was deleted."
      } else {
        "The virtualenv was not deleted."
      }
    }
    elseif($userInput -eq '') { continue }
    else { "You did not enter a valid option." }
  }
} elseif($initialInput -eq '') {
  ""; Return
} else {
  "`nThat was not a valid input.`n"
  ""; Return
}
