# Created by Declan Mullen
# Git repository can be found at git://github.com/declancm/virtualenv-creator

#!/bin/bash

while :
do

    # check if the file is exists?
    if [ ! -e "$HOME/virtualenv-creator/data/virtualenvList.txt" ]
    then
        printf "A list file does not exist. Have you created a virtualenv?\n"
        return
    elif [ ! -s $HOME/virtualenv-creator/data/virtualenvList.txt ]
    then
        printf "The list file is empty. Have you created a virtualenv?\n"
        return
    fi

    # add each line to an array
    # mapfile -t list < $HOME/virtualenv-creator/data/virtualenvList.txt
    list=()
    while IFS= read -r line; do
        list+=("$line")
    done < $HOME/virtualenv-creator/data/virtualenvList.txt

    # check that each item on the list still exists
    n=${#list}
    currentLine=${list[$n]}
    while [ -n "$currentLine" ]
    do
        if [ ! -e "$currentLine/bin/activate" ]
        then
            # remove the deleted virtualenv from the list
            sed -i "$n d" $HOME/virtualenv-creator/data/virtualenvList.txt
        fi
        # the list is incremented backwards to ensure the element positions are correct
        n=$((n - 1))
        currentLine=${list[$n]}
    done

    # check the file isn't empty
    if [ ! -s $HOME/virtualenv-creator/data/virtualenvList.txt ]
    then
        printf "The list file is empty. Have you created a virtualenv?\n"
        return
    fi

    # read the text file again
    list=()
    while IFS= read -r line; do
        list+=("$line")
    done < $HOME/virtualenv-creator/data/virtualenvList.txt

    printf "A list of your created python virtualenvs :\n\n"

    # display a list of the virtual envs
    currentLine=${list[1]}
    n=1
    while [ -n "$currentLine" ]
    do
        printf "    $n.    $currentLine\n"
        n=$((n + 1))
        currentLine=${list[$n]}
    done

    printf "\nEnter the number of a python virtualenv to select (press Enter to exit) : "
    read number

    # exit on blank input
    if [ "$number" = "" ]
    then
        printf "Exiting...\n"
        return
    fi

    printf "Enter 'a' to activate or 'd' to delete ${list[$number]} : "
    read input

    if [ "$input" = "a" ]
    then
        source ${list[$number]}/bin/activate
    elif [ "$input" = "d" ]
    then
        printf "Are you sure you want to delete ${list[$number]}? (y/n) "
        read delete
        if [ "$delete" = "y" ]
        then
            rm -rf ${list[$number]}
            printf "The virtualenv was deleted.\n"
        else
            printf "The virtualenv was not deleted.\n"
        fi
    else
        printf "You did not enter a valid option.\n"
    fi
done
