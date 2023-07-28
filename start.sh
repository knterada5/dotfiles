#!/bin/bash

# OS
OS=`uname | tr A-Z a-z`
DIR=$(cd $(dirname $0); pwd)

# Install zsh and packages.
case $OS in
  "linux")
    DIST=`cat /etc/*release | tr A-Z a-z`
    if [[ $DIST =~ "centos" ]] || [[ $DIST =~ "fedora" ]] || [[ $DIST =~ "red hat" ]]; then
      echo "Red Hat key"
    elif [[ $DIST =~ "debian" ]] || [[ $DIST =~ "ubuntu" ]]; then
      . $DIR/scripts/install_zsh_debian.sh
      zsh $DIR/scripts/install_packages_debian.sh
      exit
    fi ;;
  "darwin")
    . $DIR/scripts/install_zsh_macos.sh $GO_VER ;;
esac
