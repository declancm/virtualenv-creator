#!/bin/bash
aliasSource="alias pyvenv=\"source $HOME/virtualenv-creator/pyvenv-bash.sh\""
printf "Would you like to add an aias to bash? (y/n) "
read input
if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "yes" ] || [ "$input" = "Yes" ]
then
    if [ ! -d "$HOME/.bashrc" ]
    then
        touch -c $HOME/.bashrc
        printf "A .bashrc file was created.\n"
    fi
    if grep -qF "$aliasSource" $HOME/.bashrc;then
        printf "The source link already exists.\n"
    else
        printf "\n$aliasSource\n" >> ~/.bashrc
        printf "The alias was sourced successfully. Please restart bash for the alias to take effect.\n"
    fi
else
    printf "The alias was not added.\n"
fi
