# virtualenv-creator
A fast and easy python virtual environment creator for **linux, mac and windows** that:

- allows for python version selection after showing which versions are currently installed,
- fast library installation,
- and automatic virtualenv activation.

PowerShell Demo Video:

https://user-images.githubusercontent.com/90937622/145666215-8e32b020-b78e-433e-9fca-6258b0c0dbc0.mp4


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

- This alias can be added to ~/.bashrc (if the file doesn't exist, create it) to run the script:

      alias pyvenv='source ~/virtualenv-creator/pyvenv.sh'

### PowerShell (Windows):

- Ensure powershell has the permission to run scripts. This will also allow for the profile script to be run for powershell to allow aliases.

- To run the powershell script, the following command needs to be run:

      . ~\Documents\virtualenv-creator\pyvenv.ps1

- This alias can be added to ~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 (if the file doesn't exist, create it) to run the script:

      function runPyvenv { Invoke-Expression ". ~\Documents\virtualenv-creator\pyvenv.ps1" }
      Set-Alias pyvenv runPyvenv

