#!/bin/bash

if [ $# == 0 ]; then
  read -s -p "[sudo] password for $USER:" PSWD
else
  PSWD=$1
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
      zsh $DIR/scripts/install_packages_debian.sh $PSWD
      exit
    fi ;;
  "darwin")
    . $DIR/scripts/install_zsh_macos.sh $GO_VER ;;
esac
