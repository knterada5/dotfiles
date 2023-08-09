#!/usr/bin/env bash

read -s "PSWD?[sudo] password for $USER:"
print "\n"
read "Enter user name for git: " USER_NAME
read "Enter emai address for git: " USER_EMAIL


echo $PSWD | sudo -S apt update && sudo apt upgrade -y
echo $PSWD | sudo -S apt install -y git

git clone https://github.com/knterada5/.dotfiles.git $HOME/.dotfiles
source $HOME/.dotfiles/linux/scripts/test.sh

