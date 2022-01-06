function Open-List {
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
          Remove-Item -Path $selectedLine -Force -Recurse | Out-Null
            "The virtualenv was deleted."
        } else {
          "The virtualenv was not deleted."
        }
    }
    elseif($userInput -eq '') { continue }
      else { "You did not enter a valid option." }
  }
}
