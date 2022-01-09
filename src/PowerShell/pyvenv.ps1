# Created by Declan Mullen
# Git repository can be found at https://github.com/declancm/virtualenv-creator

$ProjectPath = (Get-Item $PSCommandPath).Directory.Parent.Parent.FullName
# $virtualenvList = Join-Path -Path $projectPath -ChildPath \data\Powershell\virtualenvList.txt

$initialInput = Read-Host -Prompt "`nEnter 'c' to create a python virtualenv or 'l' to see a list of created virtualenvs"

if($initialInput -eq 'c') {
  . "$ProjectPath\src\PowerShell\create.ps1"
  Enable-Create -ProjectPath $ProjectPath
  Return
} elseif($initialInput -eq 'l') {
  . "$ProjectPath\src\PowerShell\list.ps1"
  Return
  Open-List -ProjectPath $ProjectPath
} elseif($initialInput -eq '') {
  ""; Return
} else {
  "`nError: That was not a valid input.`n"
  Return
}
