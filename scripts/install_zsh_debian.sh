#!/bin/bash

# Update repositories.
sudo -S apt update && sudo apt upgrade -y

# Install zsh.
ZSH=`which zsh`
if [[ $ZSH =~ "not found" ]]; then
  echo "Zsh is not installed."
  echo "Install zsh."
  sudo apt install zsh -y
  echo "Change login shell to zsh."
  chsh -s /bin/zsh
else
  if [[ $SHELL =~ "/zsh"$ ]]; then
    echo "Current shell is zsh."
  else
    echo "Change login shell to zsh."
    chsh -s /bin/zsh
fi

