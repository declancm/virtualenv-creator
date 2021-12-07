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
        printf "\n$aliasSource\n" >> ~/.bashrc
        printf "\nThe alias was sourced successfully.\n\n"
    fi
else
    printf "\nThe alias was not added.\n\n"
fi
