# Created by Declan Mullen
# Git repository can be found at git://github.com/declancm/virtualenv-creator

#!/bin/bash

create() {
    printf "\nEnter the directory path where the python virtualenv will be installed: "
    read directory
    directory="${directory/#\~/$HOME}"
    workingDirectory=$(pwd)
    directory="${directory/#\./$workingDirectory}"
    printf "Enter the name of the python virtualenv: "
    read name
    if [ -d "$directory/$name" ]
    then
        printf "\nError: A folder already exists in that directory with that name.\n\n"
    else
        printf "\nThe installed python versions:\n\n"
        list=($(ls /usr/bin/python*[^config]))
        listNumber=1
        for listItem in "${list[@]}"
        do
            strippedItem=$(basename $listItem)
            printf "    $listNumber.   $strippedItem\n"
            ((listNumber++))
        done
        printf "\nEnter the list number of the python version you would like to use: "
        read selectedNumber
        selectedVersion=${list[selectedNumber]}
        mkdir -p $directory
        virtualenv --python $selectedVersion $directory/$name >/dev/null
        if [ $? -eq 0 ]
        then
            if [ ! -e "$projectPath/data/Bash/virtualenvList" ]
            then
                touch $projectPath/data/Bash/virtualenvList.txt
            fi
            if grep -Fxq "$directory/$name" $projectPath/data/Bash/virtualenvList.txt
            then
                :
            else
                printf "$directory/$name\n" >> $projectPath/data/Bash/virtualenvList.txt
            fi
            if [ -e "$projectPath/libraries.txt" ]
            then
                printf "\nA libraries.txt file was found. Do you want to install the contents into the virtualenv? (y/n): "
                read installLibraries
                if [ $installLibraries = 'y' ]
                then
                    libraries=()
                    while IFS= read -r line; do
                        libraries+=("$line")
                    done < "$projectPath/libraries.txt"

                    . $directory\/$name/bin/activate
                    if [ $? -eq 0 ]
                    then
                        strippedName=$(basename $selectedVersion)
                        if [ "${strippedName:6:1}" = "2" ]
                        then
                            pip='pip'
                        else
                            pip='pip3'
                        fi
                        printf "\nThe libraries.txt is being installed ...\n\n"
                        currentLibrary=$libraries[1]
                        n=1
                        while [ -n "$currentLibrary" ]
                        do
                            $pip -q install $currentLibrary
                            if [ $? -eq 0 ]
                            then
                                printf "The pip library '$currentLibrary' was installed successfully.\n"
                            else
                                printf "Error: The pip library '$currentLibrary' could not be installed.\n"
                            fi
                            n=$((n + 1))
                            currentLibrary=$libraries[$n]
                        done
                        deactivate
                        printf "\nThe libraries.txt installation is complete.\n\n"
                    else
                        printf "\nError: The virtualenv could not be activated.\n\n"
                        return 1
                    fi
                elif [ $installLibraries = 'n' ]
                then
                    printf "The libraries.txt will not be installed.\n"
                else
                    printf "Error: You did not enter a valid input. The libraries.txt will not be installed.\n"
                fi
            fi
            while :
            do
                printf "\nEnter the name of a library you would like to install (press Enter to skip): "
                read library
                if [ "$library" != "" ]
                then
                    . $directory\/$name/bin/activate
                    if [ $? -eq 0 ]
                    then
                        strippedName=$(basename $selectedVersion)
                        if [ "${strippedName:6:1}" = "2" ]
                        then
                            pip='pip'
                        else
                            pip='pip3'
                        fi
                        printf "\nThe pip library is being installed ...\n\n"
                        $pip -q install $library
                        if [ $? -eq 0 ]
                        then
                            printf "The pip library '$library' was installed successfully.\n"
                        else
                            printf "\nError: The pip library '$library' could not be installed.\n"
                        fi
                        deactivate
                    else
                        printf "\nError: The python virtualenv could not be activated.\n\n"
                        return 1
                    fi
                else
                    break
                fi
            done
            printf "\nDo you want the virtualenv to be ignored by git? (y/n): "
            read gitignore
            if [ "$gitignore" = "y" ]
            then
                # rm -f $directory\/$name/.gitignore
                # touch -f $directory\/$name/.gitignore
                # printf "*" $directory\/$name/.gitignore >/dev/null
            elif [ "$gitignore" = "n" ]
            then
                printf "The python virtualenv will not be ignored by git.\n"
                rm -f $directory\/$name/.gitignore
            else
                printf "\nError: You did not enter a valid input. The python virtualenv will not be ignored by git.\n"
                rm -f $directory\/$name/.gitignore
            fi
            printf "\nDo you want to activate the python venv? (y/n): "
            read activate
            if [ "$activate" = "y" ]
            then
                . $directory\/$name/bin/activate
            elif [ "$activate" = "n" ]
            then
                printf "The python virtualenv will not be activated.\n"
            else
                printf "\nError: You did not enter a valid input. The python virtualenv will not be activated.\n"
            fi
            if [ "$directory" = "." ]
            then
                directory=$(pwd)
            elif [ "${directory:0:2}" = "./" ]
            then
                cd $directory
                directory=$(pwd)
                # cd - 2>&1 >/dev/null
                cd $OLDPWD
            fi
            printf "\nThe python virtualenv creation is complete.\n\n"
            # printf "To manually activate (from within any directory): source $directory/$name/bin/activate\n\n"
        else
            printf "\nError: The python virtualenv could not be created.\n\n"
        fi
    fi
    return
}
