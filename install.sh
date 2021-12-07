newAlias="alias pyvenv='source ~/pyvenv-creator/pyvenv.sh"
[ ! -d ~/pyvenv-creator ] && mkdir -p ~/pyvenv-creator && printf "\nThe pyvenv-creator directory was created.\n\n"
cp -f ./pyvenv.sh ~/pyvenv-creator/pyvenv.sh
printf "Would you like to install the alias for bash or zsh? "
read input
if [ "$input" = "bash" ] || [ "$input" = "Bash" ]
then
    if grep -qF "$newAlias" ~/.bashrc;then
        printf "\nThe alias already exists.\n"
    else
        printf "$newAlias" >> ~/.bashrc
    fi
elif [ "$input" = "zsh" ] || [ "$input" = "Zsh" ]
then
    if grep -qF "$newAlias" ~/.zshrc;then
        printf "\nThe alias already exists.\n"
    else
        printf "$newAlias" >> ~/.zshrc
    fi
else
    printf "\nYou did not enter a valid option. Neither were created.\n"
fi
