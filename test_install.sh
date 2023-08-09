#!/usr/bin/env bash

read -s -p "[sudo] password for $USER:" PSWD
print "\n"
read -p "Enter user name for git: " USER_NAME
read -p "Enter emai address for git: " USER_EMAIL


echo $PSWD | sudo -S apt update && sudo apt upgrade -y
echo $PSWD | sudo -S apt install -y git

git clone https://github.com/knterada5/.dotfiles.git $HOME/.dotfiles
source $HOME/.dotfiles/linux/scripts/test.sh

