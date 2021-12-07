newAlias="alias pyvenv=\"source ~/pyvenv-creator/pyvenv.sh\""
[ ! -d ~/pyvenv-creator ] && mkdir -p ~/pyvenv-creator && printf "\nThe pyvenv-creator directory was created.\n"
cp -f ./pyvenv.sh ~/pyvenv-creator/pyvenv.sh
printf "\nWould you like to install the alias for bash or zsh? "
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
    if grep -qF "$newAlias" ~/.zshrc;then
        printf "\nThe alias already exists.\n\n"
    else
        printf "$newAlias\n" >> ~/.zshrc
        printf "\nThe alias was added successfully.\n\n"
    fi
else
    printf "\nYou did not enter a valid option. Neither were created.\n\n"
fi
