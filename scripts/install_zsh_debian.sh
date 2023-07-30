#!/bin/bash

if [ $# == 0 ]; then
  read -s -p "[sudo] password for $USER:" PSWD
else
  PSWD=$1
fi

# Update repositories.
echo $PSWD | sudo -S apt update && sudo apt upgrade -y

# Install zsh.
ZSH=`which zsh`
if [[ $ZSH =~ "not found" ]] || [[ $ZSH == "" ]]; then
  echo "Zsh is not installed."
  echo "Install zsh."
  echo $PSWD | sudo -S apt install -y zsh
  echo "Change login shell to zsh."
  echo $PSWD | chsh -s /bin/zsh
else
  if [[ $SHELL =~ "/zsh"$ ]]; then
    echo "Current shell is zsh."
  else
    echo "Change login shell to zsh."
    chsh -s /bin/zsh
  fi
fi
