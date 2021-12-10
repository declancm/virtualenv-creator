# Created by Declan Mullen
# Git repository can be found at git://github.com/declancm/virtualenv-creator

#!/usr/bin/env bash
printf "Enter the directory path where the python virtualenv will be installed: "
read directory
directory="${directory/#\~/$HOME}"
printf "Enter the name of the python virtualenv: "
read name
if [ ! -d "$directory/$name" ]
then
    printf "\nThe installed python versions:\n\n"
    ls -ls /usr/bin/python*[^config]
    printf "\nEnter the version of python you would like to use (eg. 3.9): "
    read version
    mkdir -p $directory
    printf "\nThe python virtualenv is being created...\n\n"
    virtualenv --python python$version $directory/$name >/dev/null
    if [ $? -eq 0 ]
    then
        printf "Would you like to install pandas and matplotlib? (y/n) "
        read libraries
        if [ "$libraries" = "y" ] || [ "$libraries" = "Y" ] || [ "$libraries" = "yes" ] || [ "$libraries" = "Yes" ]
        then
            source $directory\/$name/bin/activate
            if [ $? -eq 0 ]
            then
                if [ "${version:0:1}" == "3" ]
                then
                    pip3 install pandas
                    pip3 install matplotlib
                    #pip3 install sklearn
                elif [ "${version:0:1}" == "2" ]
                then
                    pip2 install pandas
                    pip2 install matplotlib
                    #pip2 install sklearn
                fi
                deactivate
            else
                printf "The python virtualenv could not be activated."
            fi
        elif [ "$libraries" = "n" ] || [ "$libraries" = "N" ] || [ "$libraries" = "no" ] || [ "$libraries" = "No" ]
        then
            printf "Libraries will not be installed.\n"
        else
            printf "You did not enter a valid answer. Libraries will not be installed.\n"
        fi
        printf "\nDo you want to activate the python venv? (y/n) "
        read activate
        if [ "$activate" = "y" ] || [ "$activate" = "Y" ] || [ "$activate" = "yes" ] || [ "$activate" = "Yes" ]
        then
            source $directory\/$name/bin/activate
        elif [ "$activate" = "n" ] || [ "$activate" = "N" ] || [ "$activate" = "no" ] || [ "$activate" = "No" ]
        then
            printf "The python virtualenv will not be activated.\n"
            printf "To activate: source $directory/$name/bin/activate\n"
        else
            printf "You did not enter a valid answer. The python virtualenv will not be activated.\n"
            printf "To activate: source $directory/$name/bin/activate\n"
        fi
        printf "\nThe python virtualenv is created.\n\n"
    else
        printf "\nThe python virtualenv could not be created.\n"
    fi
    # cd -
else
    printf "A folder already exists in that directory with that name.\n"
fi
