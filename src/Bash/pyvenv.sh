# Created by Declan Mullen
# Git repository can be found at git://github.com/declancm/virtualenv-creator

#!/bin/bash

# projectPath="$(realpath "$(dirname "$BASH_SOURCE")")"
projectPath="$(dirname "$BASH_SOURCE")"
cd $projectPath
projectPath=$(pwd)
cd $OLDPWD

printf "\nEnter 'c' to create a python virtualenv or 'l' to see a list of created virtualenvs: "
read input
if [ "$input" = "c" ]
then
    . $projectPath/src/Bash/create.sh
    create
elif [ "$input" = "l" ]
then
    . $projectPath/src/Bash/list.sh
    list
else
    printf "\nError: You did not enter a valid input.\n\n"
fi
return
