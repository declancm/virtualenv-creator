# Created by Declan Mullen
# Git repository can be found at https://github.com/declancm/virtualenv-creator

$projectPath = (Get-Item $PSCommandPath).Directory.Parent.Parent.FullName
$virtualenvList = Join-Path -Path $projectPath -ChildPath \data\Powershell\virtualenvList.txt

$initialInput = Read-Host -Prompt "`nEnter 'c' to create a python virtualenv or 'l' to see a list of created virtualenvs"
if(-Not (Test-Path -Path $virtualenvList -PathType Leaf)) {
  New-Item -ItemType File -Path $virtualenvList | Out-Null
}
if($initialInput -eq 'c') {
  . "$projectPath\src\PowerShell\create.ps1"
  Enable-Create
} elseif($initialInput -eq 'l') {
  . "$projectPath\src\PowerShell\list.ps1"
  Open-List -ProjectPath $projectPath
} elseif($initialInput -eq '') {
  ""; Return
} else {
  "`nThat was not a valid input.`n"
  ""; Return
}
