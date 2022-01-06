# Created by Declan Mullen
# Git repository can be found at git://github.com/declancm/virtualenv-creator

#!/bin/bash

printf "\nEnter 'c' to create a python virtualenv or 'l' to see a list of created virtualenvs: "
read input
if [ "$input" = "c" ]
then
    . $HOME/virtualenv-creator/src/Bash/create.sh
    create
elif [ "$input" = "l" ]
then
    . $HOME/virtualenv-creator/src/Bash/list.sh
    list
else
    printf "\nError: You did not enter a valid input.\n\n"
fi

return
