# Created by Declan Mullen
# Git repository can be found at git://github.com/declancm/python-venv-creator

#!/usr/bin/env bash

if [[ "$(python3 -V)" =~ "Python 3" ]]
then
    printf "\nEnter the directory path where the python virtual environment will be installed: "
    read directory
    directory="${directory/#\~/$HOME}"
    printf "Enter the name of the python virtual environment: "
    read name
    if [ ! -d "$directory/$name" ]
    then
        mkdir -p $directory
        printf "\nThe python virtual environment is being created...\n\n"
        python3 -m venv $directory/$name
        if [ $? -eq 0 ]
        then
            printf "Would you like to install pandas and matplotlib? (y/n) "
            read libraries
            if [ "$libraries" = "y" ] || [ "$libraries" = "Y" ] || [ "$libraries" = "yes" ] || [ "$libraries" = "Yes" ]
            then
                source $directory\/$name/bin/activate
                pip3 install pandas
                pip3 install matplotlib
                #pip3 install sklearn
                deactivate
            elif [ "$libraries" != "n" ] || [ "$libraries" != "N" ] || [ "$libraries" != "no" ] || [ "$libraries" != "No" ]
            then
                printf "Libraries will not be installed.\n"
            else
                printf "You did not enter a valid answer. Libraries will not be installed.\n"
            fi
            printf "\nDo you want to activate the python venv? (y/n) "
            read activate
            if [ "$activate" = "y" ] || [ "$activate" = "Y" ] || [ "$activate" = "yes" ] || [ "$activate" = "Yes" ]
            then
                source $name/bin/activate
            elif [ "$activate" != "n" ] || [ "$activate" != "N" ] || [ "$activate" != "no" ] || [ "$activate" != "No" ]
            then
                printf "The python venv will not be activated.\n"
                printf "To activate: source $directory/$name/bin/activate\n"
            else
                printf "You did not enter a valid answer. The python venv will not be activated.\n"
                printf "To activate: source $directory/$name/bin/activate\n"
            fi
            printf "\nThe python venv creation is complete.\n\n"
        else
            printf "\nThe python virtual environment could not be created.\n"
        fi
        # cd -
    else
        printf "A folder already exists in that directory with that name.\n"
    fi
else
    printf "Python 3 is not installed.\n"
fi
