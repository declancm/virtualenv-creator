# Created by Declan Mullen
# Git repository can be found at git://github.com/declancm/virtualenv-creator

function Open-List {
  param (
  [Parameter(Mandatory = $true, Position = 0)] [Object]$ProjectPath
  )

  $virtualenvList = Join-Path -Path $ProjectPath -ChildPath '\data\Powershell\virtualenvList.txt'

  if (Test-Path $virtualenvList) {
      if ($Null -eq (Get-Content -Path $virtualenvList)) {
        $createVirtualenv = Read-Host -Prompt "`nThe list file is empty. Do you want to create a virtualenv? (y/n): "
        if ($createVirtualenv -eq 'y') {
          . "$ProjectPath\src\PowerShell\create.ps1"
          Enable-Create -ProjectPath $ProjectPath
          Return
        }
        elseif ($createVirtualenv -eq 'n') {
          ""; Return
        }
        "`nError: That was not a valid input.`n"; Return
      }
    }
    else {
      $createVirtualenv = Read-Host -Prompt "`nA list file does not exist. Do you want to create a virtualenv? (y/n): "
      if ($createVirtualenv -eq 'y') {
        . "$ProjectPath\src\PowerShell\create.ps1"
        Enable-Create -ProjectPath $ProjectPath
        Return
      }
      elseif ($createVirtualenv -eq 'n') {
        ""; Return
      }
      "`nError: You did not enter a valid input.`n"; Return
    }

  while($true) {
    [string[]]$list = Get-Content -Path $virtualenvList
    $n = $list.Length - 1
    $currentLine = $list[$n]
    while($Null -ne $currentLine) {
      #delete line if it doesn't exist
      if(-Not (Test-Path $currentLine\Scripts\activate.ps1)) {
        # Set-Content -Path $virtualenvList -Value (Get-Content -Path $virtualenvList | Select-String -Pattern $currentLine)
        $currentLine = [regex]::Escape($currentLine)
        Set-Content -Path $virtualenvList -Value (Get-Content -Path $virtualenvList | Select-String -Pattern $currentLine -NotMatch)
      }
      $n--
      $currentLine = $list[$n]
    }

    if ($Null -eq (Get-Content -Path $virtualenvList)) {
        $createVirtualenv = Read-Host -Prompt "`nThe list file is empty. Do you want to create a virtualenv? (y/n)"
        if ($createVirtualenv -eq 'y') {
          . "$ProjectPath\src\PowerShell\create.ps1"
          Enable-Create -ProjectPath $ProjectPath
          Return
        }
        elseif ($createVirtualenv -eq 'n') {
          ""; Return
        }
        "`nError: You did not enter a valid input.`n"; Return
      }

    [string[]]$list = Get-Content -Path $virtualenvList
    "`nA list of your created python virtualenvs`n"
    $n = 0
    $nPlus = 1
    $currentLine = $list[$n]
    while($Null -ne $currentLine) {
      "    $nPlus.   $currentLine"
      $n++
      $nPlus++
      $currentLine = $list[$n]
    }
    $inputNumber = Read-Host -Prompt "`nTo select a virtualenv enter the list number (or press Enter to exit)"
    if ($inputNumber -eq '') { ""; Return }
    $number = [int]$inputNumber
    $selectedLine = $list[$number - 1]
    $userInput = Read-Host -Prompt "`nEnter 'a' to activate or 'd' to delete '$selectedLine' (or press Enter to cancel)"
    if($userInput -eq 'a') {
      Invoke-Expression "$selectedLine\Scripts\activate.ps1"
      "The virtualenv was activated.`n"
      Return
    }
    elseif($userInput -eq 'd') {
      $delete = Read-Host -Prompt "Are you sure you want to delete '$selectedLine'? (y/n)"
      if($delete -eq 'y') {
        Remove-Item -Path $selectedLine -Force -Recurse | Out-Null
        "The virtualenv was deleted."
        Open-List -ProjectPath $ProjectPath
        Return
      } else {
        "The virtualenv was not deleted."
        Open-List -ProjectPath $ProjectPath
        Return
      }
    }
    elseif($userInput -eq '') { continue }
    else { "`nError: You did not enter a valid input." }
  }
}
