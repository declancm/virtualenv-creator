# virtualenv-creator
A fast and easy python virtual environment creator for **linux, mac and windows** that:

- allows for python version selection after showing which versions are currently installed,
- fast library selection,
- and automatic virtualenv activation.

### Demo Video:

https://user-images.githubusercontent.com/90937622/145638921-d26da6b2-b47f-45c7-beae-f397c4946b20.mp4


## Dependencies

- python/python3
- pip/pip3
- virtualenv

## Installation

### BASH (Linux and Mac):

1. Clone the git repo:

       git clone https://github.com/declancm/virtualenv-creator.git ~/virtualenv-creator

2. Run the installation script if you wish to add the alias to your .bashrc:

       . ~/virtualenv-creator/install.sh

### PowerShell (Windows):

1. Clone the git repo:

       git clone https://github.com/declancm/virtualenv-creator.git ~\Documents\virtualenv-creator

## Instructions

### BASH (Linux and Mac):

**If the install.sh was used, just type 'pyvenv' into the terminal to run the script and create a python virtualenv.**

To manually install:

- To run the bash script, the following command needs to be run:

      source ~/virtualenv-creator/pyvenv.sh

- An alias can be added to ~/.bashrc (if the file doesn't exist, create it) to run the script, such as the following:

      alias pyvenv='source ~/virtualenv-creator/pyvenv.sh'

### PowerShell (Windows):

- Ensure powershell has the permission to run scripts. This will also allow for the profile script to be run for powershell to allow aliases.

- To run the powershell script, the following command needs to be run:

      . ~\Documents\virtualenv-creator\pyvenv.ps1

- An alias can be added to ~\Documents\profile.ps1 (if the file doesn't exist, create it) to run the script:

      Set-Alias pyvenv . ~\Documents\virtualenv-creator\pyvenv.ps1

