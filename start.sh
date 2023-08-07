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
DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

# Install zsh and packages.
case $OS in
  "linux")
    DIST=`cat /etc/*release | tr A-Z a-z`
    if [[ $DIST =~ "centos" ]] || [[ $DIST =~ "fedora" ]] || [[ $DIST =~ "red hat" ]]; then
      echo "Red Hat key"
    elif [[ $DIST =~ "debian" ]] || [[ $DIST =~ "ubuntu" ]]; then
      . $DIR/scripts/install_zsh_debian.sh $PSWD
      . $DIR/scripts/install_fonts.sh $PSWD
      zsh $DIR/scripts/install_packages_debian.sh $PSWD $USER_NAME $USER_EMAIL
      exit
    fi ;;
  "darwin")
    . $DIR/scripts/install_zsh_macos.sh $GO_VER ;;
esac
