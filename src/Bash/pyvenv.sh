# Created by Declan Mullen
# Git repository can be found at git://github.com/declancm/virtualenv-creator

#!/bin/bash

# projectPath="$(realpath "$(dirname "$0")")"
projectPath="$(dirname "$0")"
# projectPath="$(dirname "$(realpath "$0")")"
cd $projectPath/../..
projectPath=$(pwd)
cd $OLDPWD
# printf "BASH_SOURCE: $(dirname "${BASH_SOURCE}")"

# printf "projectPath is: $projectPath"

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
