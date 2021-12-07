[ ! -d ~/pyvenv-creator ] && mkdir -p ~/pyvenv-creator && printf "The pyvenv-creator directory was created.\n"
aliasSource="source $HOME/pyvenv-creator/pyvenv.sh"
cp -f ./pyvenv.sh ~/pyvenv-creator/pyvenv.sh
[ -d ~/pyvenv-creator/pyvenv-alias ] && rm -f ~/pyvenv-creator/pyvenv-alias
printf "alias pyvenv=\"source $HOME/pyvenv-creator/pyvenv.sh\"" >> ~/pyvenv-creator/pyvenv-alias
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
