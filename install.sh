[ ! -d ~/pyvenv-creator ] && mkdir -p ~/pyvenv-creator && printf "\nThe pyvenv-creator directory was created.\n"
aliasSource="source $HOME/pyvenv-creator/pyvenv.sh"
cp -f ./pyvenv.sh ~/pyvenv-creator/pyvenv.sh
cp -f ./pyvenv-alias ~/pyvenv-creator/pyvenv-alias
printf "\nWould you like to source the alias for bash? (y/n) "
read input
if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "yes" ] || [ "$input" = "Yes" ]
then
    if grep -qF "$aliasSource" ~/.bashrc;then
        printf "\nThe source link already exists.\n\n"
    else
        printf "$aliasSource" >> ~/.bashrc
        printf "\nThe alias was sourced successfully.\n\n"
    fi
elif [ "$input" = "zsh" ] || [ "$input" = "Zsh" ]
then
    "\nThe alias was not added.\n\n"
else
    printf "\nYou did not enter a valid option. Neither were created.\n\n"
fi
