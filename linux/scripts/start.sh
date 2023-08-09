#!/bin/bash

if [ $# = 0 ]; then
  read -s -p "[sudo] password for $USER:" PSWD
  print "\n"
  read -p "Enter user name for git: " USER_NAME
  read -p "Enter emai address for git: " USER_EMAIL
else
  PSWD=$1
  USER_NAME=$2
  USER_EMAIL=$3
fi


# OS
OS=`uname | tr A-Z a-z`

# Dotfile directory
DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); cd ..; pwd)


# Setting ssh-key
function keygen () {
  printf '\a'
  read -n1 -p "Do you Set ssh-key for github? (y/N): " yn
  printf '\n'
  if [[ $yn = [yY] ]]; then
    mkdir -p $HOME/.ssh
    cd $HOME/.ssh
    ssh-keygen
    read -p "Enter your ssh-key name for github. (Default: id_rsa): " SSH_KEY
    cat $DIR/src/ssh/config | sed "s/ID_RSA/$SSH_KEY/" > $HOME/.ssh/config
  fi
}


# Install zsh and packages.
case $OS in
  "linux")
    DIST=`cat /etc/*release | tr A-Z a-z`
    if [[ $DIST =~ "centos" ]] || [[ $DIST =~ "fedora" ]] || [[ $DIST =~ "red hat" ]]; then
      echo "Red Hat key"
    elif [[ $DIST =~ "debian" ]] || [[ $DIST =~ "ubuntu" ]]; then
      echo $PSWD | sudo -S apt update && sudo apt upgrade -y
      . $DIR/scripts/install_zsh_debian.sh $PSWD
      . $DIR/scripts/install_fonts.sh $PSWD
      zsh $DIR/scripts/install_packages_debian.sh $PSWD $USER_NAME $USER_EMAIL
      keygen
      exit
    fi ;;
  "darwin")
    . $DIR/scripts/install_zsh_macos.sh $GO_VER ;;
esac
