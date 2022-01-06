import os

def expandPath(path):
    path = os.path.expandvars(path)
    path = os.path.expanduser(path)
    path = os.path.abspath(path)
    return path

def addAlias(alias, profileLocation):
    with open(profileLocation, 'a+', encoding='utf8') as profile:
        profile.seek(0)
        if os.path.getsize(profileLocation) == 0:
            profile.write(alias)
            profile.close()
            print("\nThe alias has been installed for '{}'.".format(shell))
            return
        elif alias not in profile:
            profile.write("\n{}".format(alias))
            profile.close()
            print("\nThe alias has been installed for '{}'.".format(shell))
            return
        profile.close()
        exit("\nThe alias has already been added for '{}'.\n".format(shell))

while True:
    shellList = ["Bash (Linux)", "ZSH", "PowerShell (Windows)", "Windows PowerShell"]
    print("\nList of supported shells: \n")
    n = 0
    for item in shellList:
        print("    {}.   {}".format(n, item))
        n += 1
    shellNumber = input("\nEnter the list number for your desired shell (or press Enter to exit): ")
    if shellNumber == '':
        exit("")
    try:
        shellNumber = int(shellNumber)
    except ValueError:
        print("\nError: You did not enter a valid inupt. Please enter an integer.\n")
        continue
    confirmation = input("\nAre you sure you want to install for the shell '{}' ? (y/n) : ".format(shellList[shellNumber]))
    if confirmation == 'y':
        shell = shellList[shellNumber]
        break
    elif confirmation == 'n':
        continue
    else:
        exit("\nError: You did not enter a valid input. Installation cancelled.\n")

projectPath = os.getcwd()

if shell == "Bash (Linux)":
    profileLocation = expandPath('~/.bashrc')
    alias = "alias pyvenv='source {}/src/Bash/pyvenv.sh'".format(projectPath)
    addAlias(alias, profileLocation)
    exit("\nPlease run '. ~/.bashrc' to refresh your terminal configuration and complete installation.\n")

if shell == "ZSH":
    profileLocation = expandPath('~/.zshrc')
    alias = "alias pyvenv='source {}/src/Bash/pyvenv.sh'".format(projectPath)
    addAlias(alias, profileLocation)
    exit("\nPlease run '. ~/.zshrc' to reload your terminal configuration and complete installation.\n")

elif shell == "PowerShell (Windows)":
    profileLocation = expandPath('%USERPROFILE%\\Documents\\PowerShell\\Microsoft.PowerShell_profile.ps1')
    alias = "function runPyvenv {{ Invoke-Expression \"pwsh /nologo -ExecutionPolicy Bypass -NoExit -File {}\\src\\PowerShell\\pyvenv.ps1\" }}; Set-Alias pyvenv runPyvenv".format(projectPath)
    addAlias(alias, profileLocation)
    exit("\nPlease run '. $profile' to reload your terminal configuration and complete installation.\n")

elif shell == "Windows PowerShell":
    profileLocation = expandPath('%USERPROFILE%\\Documents\\WindowsPowerShell\\Microsoft.PowerShell_profile.ps1')
    alias = "function runPyvenv {{ Invoke-Expression \"PowerShell.exe /nologo -ExecutionPolicy Bypass -NoExit -File {}\\src\\PowerShell\\pyvenv.ps1\" }}; Set-Alias pyvenv runPyvenv".format(projectPath)
    addAlias(alias, profileLocation)
    exit("\nPlease run '. $profile' to reload your terminal configuration and complete installation.\n")

else:
    exit("\nError: A valid shell wasn't selected.\n")

