aliasSource="source $HOME/virtualenv-creator/pyvenv.sh"
printf "Would you like to source the alias for bash? (y/n) "
read input
if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "yes" ] || [ "$input" = "Yes" ]
then
    if grep -qF "$aliasSource" ~/.bashrc;then
        printf "The source link already exists.\n"
    else
        printf "\n$aliasSource\n" >> ~/.bashrc
        printf "The alias was sourced successfully.\n"
    fi
else
    printf "The alias was not added.\n"
fi
