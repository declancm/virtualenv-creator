# virtualenv-creator
A fast and easy python virtual environment creator for **linux, mac and windows** that:

- allows for python version selection after displaying currently installed versions,
- fast library installation,
- and automatic virtualenv activation.

### PowerShell Demo Video:

https://user-images.githubusercontent.com/90937622/145666970-28a7a39f-7852-4f28-a398-cee993c00f5e.mp4


## Dependencies

- python/python3
- pip/pip3
- virtualenv

## Installation

### BASH (Linux and Mac):

1. Clone the git repo:

       cd ~\Documents && git clone https://github.com/declancm/virtualenv-creator.git

2. Run the installation script if you wish to add the alias to your .bashrc:

       . ~/virtualenv-creator/install.sh

### PowerShell (Windows):

1. Clone the git repo:

       git clone https://github.com/declancm/virtualenv-creator.git ~\Documents\virtualenv-creator

1. Run the installation script if you wish to add the alias to your profile.ps1:

       . ~\Documents\virtualenv-creator\install.ps1

## Instructions

### BASH (Linux and Mac):

**If the install.sh was used, just type 'pyvenv' into bash to run the script and create a python virtualenv.**

To manually install:

- To run the bash script, the following command needs to be run:

      source ~/virtualenv-creator/pyvenv.sh

- This alias can be added to ~/.bashrc (if the file doesn't exist, create it) to run the script:

      alias pyvenv='source ~/virtualenv-creator/pyvenv.sh'

### PowerShell (Windows):

- Ensure powershell has the permission to run scripts. This will also allow for the profile script to be run for powershell to allow aliases.

**If the install.ps1 was used, just type 'pyvenv' into PowerShell to run the script and create a python virtualenv.**

To manually install:

- To run the powershell script, the following command needs to be run:

      . ~\Documents\virtualenv-creator\pyvenv.ps1

- This alias can be added to the location output by 'echo $profile' (if the file doesn't exist, create it) to run the script:

      function runPyvenv { Invoke-Expression ". ~\Documents\virtualenv-creator\pyvenv.ps1" }
      Set-Alias pyvenv runPyvenv

