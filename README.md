# python-venv-creator
A fast and easy python virtual environment creator for **linux, mac and windows** with some optional pre-installed python libraries.

## Dependencies

- python3
- pip3

## Installation

### BASH (Linux and Mac):

1. Clone the git repo:

       git clone https://github.com/declancm/python-venv-creator.git ~/python-venv-creator

2. Run the installation script if you wish to add the alias to your bashrc:

       . ~/python-venv-creator/install.sh

### PowerShell (Windows):

1. Clone the git repo:

       git clone https://github.com/declancm/python-venv-creator.git ~\Documents\python-venv-creator

## Instructions

### BASH (Linux and Mac):

**If the install.sh was used, just type 'pyvenv' into the terminal to run the script and create a python venv.**

To manually install:

- To run the bash script, the following command needs to be run:

      source <path-to-directory>/pyvenv.sh

- An alias can be added to ~/.bashrc (if the file doesn't exist, create it) to run the script, such as the following:

      alias pyvenv='source ~/python-venv-creator/pyvenv.sh'

### PowerShell (Windows):

Ensure powershell has the permission to run scripts. This will also allow for the profile script to be run for powershell to allow aliases.

To run the powershell script, the following command needs to be run:

    . ~\Documents\python-venv-creator\pyvenv.ps1

An alias can be added to ~\Documents\profile.ps1 (if the file doesn't exist, create it) to run the script, such as the following:

    Set-Alias pyvenv . ~\Documents\python-venv-creator\pyvenv.ps1

