# Created by Declan Mullen
# Git repository can be found at git://github.com/declancm/virtualenv-creator

#!/bin/bash
printf "Enter the directory path where the python virtualenv will be installed: "
read directory
directory="${directory/#\~/$HOME}"
printf "Enter the name of the python virtualenv: "
read name
if [ -d "$directory/$name" ]
then
    printf "A folder already exists in that directory with that name.\n"
else
    printf "\nThe installed python versions:\n\n"
    ls -ls /usr/bin/python*[^config]
    printf "\nEnter the version of python you would like to use (eg. 3.9): "
    read version
    mkdir -p $directory
    printf "\nThe python virtualenv is being created...\n\n"
    virtualenv --python python$version $directory/$name >/dev/null
    if [ $? -eq 0 ]
    then
        while :
        do
            printf "Enter the name of a library you would like to install (press Enter to skip) : "
            read libraries
            if [ "$libraries" != "" ]
            then
                source $directory\/$name/bin/activate
                if [ $? -eq 0 ]
                then
                    if [ "${version:0:1}" = "3" ]
                    then
                        pip3 install $libraries
                        if [ $? -eq 0 ]
                        then
                            printf "\nThe library installation was successfull.\n\n"
                        else
                            printf "\nThe library installation was unsuccessful.\n\n"
                        fi
                    elif [ "${version:0:1}" = "2" ]
                    then
                        pip install $libraries
                        if [ $? -eq 0 ]
                        then
                            printf "\nThe library installation was successfull.\n\n"
                        else
                            printf "\nThe library installation was unsuccessful.\n\n"
                        fi
                    fi
                    deactivate
                else
                    printf "The python virtualenv could not be activated."
                fi
            else
                break
            fi
        done
        printf "\nDo you want to activate the python venv? (y/n) "
        read activate
        if [ "$activate" = "y" ] || [ "$activate" = "Y" ] || [ "$activate" = "yes" ] || [ "$activate" = "Yes" ]
        then
            source $directory\/$name/bin/activate
        elif [ "$activate" = "n" ] || [ "$activate" = "N" ] || [ "$activate" = "no" ] || [ "$activate" = "No" ]
        then
            printf "The python virtualenv will not be activated.\n"
        else
            printf "You did not enter a valid answer. The python virtualenv will not be activated.\n"
        fi
        if [ "$directory" = "." ]
        then
            directory=$(pwd)
        elif [ "${directory:0:2}" = "./" ]
        then
            cd $directory
            directory=$(pwd)
            cd -
        fi
        printf "\nThe python virtualenv is created.\nTo manually activate (from within any directory): source $directory/$name/bin/activate\n\n"
    else
        printf "\nThe python virtualenv could not be created.\n"
    fi
fi
