# Created by Declan Mullen
# Git repository can be found at git://github.com/declancm/git-auto-commit

#!/usr/bin/env bash

if [[ "$(python3 -V)" =~ "Python 3" ]]
then
    printf '\nEnter the directory path where the python virtual environment will be installed:\n\n'
    read directory
    printf '\nEnter the name of the python virtual environment:\n\n'
    read name
    if [ ! -d "$directory/$name" ]
    then
        printf '\nThe python virtual environment is being created...\n\n'
        python3 -m venv $directory/$name
        if [ $? -eq 0 ]
        then
            printf '\nWould you like to install pandas, matplotlib and sklearn? (y/n)\n\n'
            read libraries
            if [ '$libraries' = 'y' ] || [ '$libraries' = 'Y' ] || [ '$libraries' = 'yes' ] || [ '$libraries' = 'Yes' ]
            then
                source ./pythonvenv/bin/activate
                pip3 install pandas
                pip3 install matplotlib
                pip3 install sklearn
                deactivate
            elif [ '$libraries' != 'n' ] || [ '$libraries' != 'N' ] || [ '$libraries' != 'no' ] || [ '$libraries' != 'No' ]
            then
                printf "\nYou did not enter a valid answer. Libraries will not be installed.\n\n"
            fi
            printf '\nThe python virtual environment was created.\n\n'
        else
            printf '\nThe python virtual environment could not be created.\nCheck that pip3 and virtualenv are installed.\n\n'
        fi
    else
        printf '\nA folder already exists in that directory with that name.\n\n'
    fi
else
    printf '\nPython 3 is not installed.\n\n'
fi
