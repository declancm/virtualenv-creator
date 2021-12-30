# Created by Declan Mullen
# Git repository can be found at git://github.com/declancm/virtualenv-creator

#!/bin/bash

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

# display a list of the virtual envs
currentLine=${list[1]}
n=1
while [ -n "$currentLine" ]
do
    printf "$n. $currentLine\n"
    n=$((n + 1))
    currentLine=${list[$n]}
done

# allow for easy activation or deletion of a virtualenv
