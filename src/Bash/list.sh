# Created by Declan Mullen
# Git repository can be found at git://github.com/declancm/virtualenv-creator

#!/bin/bash

. $projectPath/src/Bash/create.sh

check_list() {
    # check if the file is exists?
    if [ ! -e "$virtualenvList" ]
    then
        printf "\nA list file does not exist. Do you want to create a virtualenv? (y/n): "
        read createVirtualenv
        if [ "$createVirtualenv" = "y" ]
        then
            create
            return 1
        elif [ "$createVirtualenv" = "n" ]
        then
            printf "\n"
            return 1
        else
            printf "\nError: You did not enter a valid input.\n\n"
            return 1
        fi
    elif [ ! -s $virtualenvList ]
    then
        printf "\nThe list file is empty. Do you want to create a virtualenv? (y/n): "
        read createVirtualenv
        if [ "$createVirtualenv" = "y" ]
        then
            create
            return 1
        elif [ "$createVirtualenv" = "n" ]
        then
            printf "\n"
            return 1
        else
            printf "\nError: You did not enter a valid input.\n\n"
            return 1
        fi
    else
        return 0
    fi
}

list() {
    virtualenvList="$projectPath/data/Bash/virtualenvList.txt"
    while :
    do
        check_list
        if [ $? -eq 1 ]
        then
            return
        fi

        # add each line to an array
        # mapfile -t list < $HOME/virtualenv-creator/data/virtualenvList.txt
        list=()
        while IFS= read -r line; do
            list+=("$line")
        done < $virtualenvList

        # check that each item on the list still exists
        n=${#list}
        currentLine=${list[$n]}
        while [ -n "$currentLine" ]
        do
            if [ ! -e "$currentLine/bin/activate" ]
            then
                # remove the deleted virtualenv from the list
                sed -i "$n d" $virtualenvList
            fi
            # the list is incremented backwards to ensure the element positions are correct
            n=$((n - 1))
            currentLine=${list[$n]}
        done

        check_list
        if [ $? -eq 1 ]
        then
            return
        fi

        # read the text file again
        list=()
        while IFS= read -r line; do
            list+=("$line")
        done < $virtualenvList

        printf "\nA list of your created python virtualenvs:\n\n"

        # display a list of the virtual envs
        currentLine=${list[1]}
        n=1
        while [ -n "$currentLine" ]
        do
            printf "    $n.    $currentLine\n"
            n=$((n + 1))
            currentLine=${list[$n]}
        done

        printf "\nTo select a virtualenv enter the list number (or press Enter to exit): "
        read number

        # exit on blank input
        if [ "$number" = "" ]
        then
            printf "\n"
            return
        fi

        printf "\nEnter 'a' to activate or 'd' to delete '${list[$number]}' (or press Enter to cancel): "
        read input

        if [ "$input" = "a" ]
        then
            source ${list[$number]}/bin/activate
            "\n"; return
        elif [ "$input" = "d" ]
        then
            printf "Are you sure you want to delete '${list[$number]}'? (y/n): "
            read delete
            if [ "$delete" = "y" ]
            then
                rm -rf ${list[$number]}
                printf "The virtualenv was deleted.\n"
            else
                printf "The virtualenv was not deleted.\n"
            fi
        elif [ "$input" = "" ]
        then
            continue
        else
            printf "\nError: You did not enter a valid input.\n\n"
        fi
    done
}
