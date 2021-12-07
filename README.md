# python-venv-creator
A fast and easy python virtual environment created for linux with some optional pre-installed libraries.

## Dependencies:
The following need to be installed (installation commands are for Ubuntu / Debian):
- python3:
  - sudo apt update && sudo apt upgrade
  - sudo apt install python3
- pip3:
  - sudo apt install python3-pip
- python-venv:
  - python3 -m pip install --user virtualenv

## Instructions:
To run the script, the following command needs to be run:
- source <path-to-pyvenv.sh>

An alias can be added to ~/.bashrc (or ~/.zshrc etc.) to run the script, such as the following:
- alias pyvenv='source ~/pyvenv.sh'

