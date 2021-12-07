#newAlias="alias pyvenv=\"source $HOME/pyvenv-creator/pyvenv.sh\""
newAlias="s
[ ! -d ~/pyvenv-creator ] && mkdir -p ~/pyvenv-creator && printf "\nThe pyvenv-creator directory was created.\n"
cp -f ./pyvenv.sh ~/pyvenv-creator/pyvenv.sh
cp -f ./pyvenv-alias ~/pyvenv-creator/pyvenv-alias
printf "\nWould you like to source the alias for bash or zsh? "
read input
if [ "$input" = "bash" ] || [ "$input" = "Bash" ]
then
    if grep -qF "$newAlias" ~/.bashrc;then
        printf "\nThe alias already exists.\n\n"
    else
        printf "$newAlias" >> ~/.bashrc
        printf "\nThe alias was added successfully.\n\n"
    fi
elif [ "$input" = "zsh" ] || [ "$input" = "Zsh" ]
then
    zshAlias="zsh_add_file \"$HOME/pyvenv-creator/pyvenv-alias"
    if grep -qF "$zshAlias" ~/.zshrc;then
        printf "\nThe alias already exists.\n\n"
    else
        printf "$zshAlias\n" >> ~/.zshrc
        printf "\nThe alias was added successfully.\n\n"
    fi
else
    printf "\nYou did not enter a valid option. Neither were created.\n\n"
fi
