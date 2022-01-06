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
            exit("\nThe alias has been installed for '{}'.\n".format(shell))
        elif alias not in profile:
            profile.write("\n{}".format(alias))
            profile.close()
            exit("\nThe alias has been installed for '{}'.\n".format(shell))
        profile.close()
        exit("\nThe alias has already been added for '{}'.\n".format(shell))

while True:
    shellList = ["Bash (Linux)", "PowerShell (Windows)"]
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
    # with open(bashrcLocation, 'a+') as bashrc:
    #     if os.path.getsize(bashrcLocation) == 0:
    #         bashrc.write(bashAlias)
    #     bashrc.seek(0)
    #     if bashAlias not in bashrc:
    #         bashrc.write("\n{}".format(bashAlias))
    #     else:
    #         bashrc.close()
    #         exit("\nThe alias has already been added for Bash.\n")
    #     bashrc.close()
    addAlias(alias, profileLocation)

elif shell == "PowerShell (Windows)":
    profileLocation = expandPath('%USERPROFILE%\\Documents\\PowerShell\\Microsoft.PowerShell_profile.ps1')
    alias = "\nfunction runPyvenv { Invoke-Expression \"PowerShell.exe /nologo -ExecutionPolicy Bypass -NoExit -File $HOME\\Documents\\virtualenv-creator\\PowerShell\\pyvenv.ps1\" }; Set-Alias pyvenv runPyvenv"
    addAlias(alias, profileLocation)

else:
    exit("\nError: A valid shell wasn't selected.\n")

