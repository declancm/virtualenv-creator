import os

def expandPath(path):
    path = os.path.expandvars(path)
    path = os.path.expanduser(path)
    path = os.path.abspath(path)
    return path

while True:
    shellList = ["Bash", "PowerShell"]
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

if shell == "Bash":
    bashrcLocation = expandPath('~/.bashrc')
    bashAlias = "alias pyvenv='source {}/src/Bash/pyvenv.sh'".format(projectPath)
    # if os.path.isfile('bashrcLocation') == False:
    with open(bashrcLocation, 'a+') as bashrc:
        if os.path.getsize(bashrcLocation) == 0:
            bashrc.write(bashAlias)
        bashrc.seek(0)
        if bashAlias not in bashrc:
            bashrc.write("\n{}".format(bashAlias))
        else:
            bashrc.close()
            exit("\nThe alias has already been added for Bash.\n")
        bashrc.close()

elif shell == "PowerShell":
    profileLocation = expandPath('%USERPROFILE%\\Documents\\PowerShell\\Microsoft.PowerShell_profile.ps1')
    "\nfunction runPyvenv { Invoke-Expression \"PowerShell.exe /nologo -ExecutionPolicy Bypass -NoExit -File $HOME\\Documents\\virtualenv-creator\\pyvenv-PS.ps1\" }\nSet-Alias pyvenv runPyvenv"

else:
    exit("\nError: A valid shell wasn't selected.\n")

    # if os.path.isfile('bashrcLocation') == False:
with open(profileLocation, 'a+') as profile:
    if os.path.getsize(profileLocation) == 0:
        profile.write(profile)
    profile.seek(0)
    if alias not in profile:
        profile.write("\n{}".format(alias))
    else:
        profile.close()
        exit("\nThe alias has already been added for Bash.\n")
    profile.close()

exit("\nThe alias has been installed for '{}'.\n".format(shell))


