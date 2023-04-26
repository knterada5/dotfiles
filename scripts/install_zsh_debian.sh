#!/bin/bash

# Arguments.
LOG=$1

# Update repositories.
sudo -S apt update && sudo apt upgrade -y

# Install zsh.
ZSH=`which zsh`
print "# Zsh information" >> $LOG
if [[ $ZSH =~ "not found" ]] || [[ $ZSH == "" ]]; then
  print "zsh is not installed." >> $LOG
  echo "Zsh is not installed."
  echo "Install zsh."
  sudo apt install zsh -y
  print "Change login shell to zsh." >> $LOG
  echo "Change login shell to zsh."
  chsh -s /bin/zsh
else
  print "zsh is already installed." >> $LOG
  if [[ $SHELL =~ "/zsh"$ ]]; then
    print "Current shell is zsh." >> $LOG
    echo "Current shell is zsh."
  else
    print "Change login shell to zsh." >> $LOG
    echo "Change login shell to zsh."
    chsh -s /bin/zsh
  fi
fi
