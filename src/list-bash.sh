# Created by Declan Mullen
# Git repository can be found at git://github.com/declancm/virtualenv-creator

#!/bin/bash

# check if the file is exists?
if [ ! -e "$HOME/virtualenv-creator/data/virtualenvList.txt" ]
then
    printf "A list file does not exist. Have you created a virtualenv?\n"
    return
fi
# add each line to an array
# mapfile -t list < $HOME/virtualenv-creator/data/virtualenvList.txt
list=()
while IFS= read -r line; do
  list+=("$line")
done < $HOME/virtualenv-creator/data/virtualenvList.txt
# check that each item on the list still exists
# printf "$list\n"
currentLine=${list[0]}
printf "$currentLine"
# while currentLine
# display a list of the virtual envs

# allow for easy activation or deletion of a virtualenv
