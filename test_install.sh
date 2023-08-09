#!/usr/bin/env bash

read -s "PSWD?[sudo] password for $USER:"
printf "\n"
read "USER_NAME?Enter user name for git: "
read "USER_EMAIL?Enter emai address for git: "


echo $PSWD | sudo -S apt update && sudo apt upgrade -y
echo $PSWD | sudo -S apt install -y git

git clone https://github.com/knterada5/.dotfiles.git $HOME/.dotfiles
source $HOME/.dotfiles/linux/scripts/test.sh

