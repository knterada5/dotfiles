#!/bin/bash

# GO latest version.
GO_VER="1.20.3"

# Setting log file.
LOG="$HOME/.dotfiles.log"
print "# Setting dotfiles log\n" >> $LOG

# OS
OS=`uname | tr A-Z a-z`
DIR=$(cd $(dirname $0); pwd)

case $OS in
  "linux")
    DIST=`cat /etc/*release | tr A-Z a-z`
    if [[ $DIST =~ "centos" ]] || [[ $DIST =~ "fedora" ]] || [[ $DIST =~ "red hat" ]]; then
      echo "Red Hat key"
    elif [[ $DIST =~ "debian" ]] || [[ $DIST =~ "ubuntu" ]]; then
      echo "OS: Linux\nDistribution: Debian" >> $LOG
      . $DIR/scripts/install_zsh_debian.sh $LOG
      zsh $DIR/scripts/install_packages_debian.sh $LOG
      zsh
    fi ;;
  "darwin")
    . $DIR/scripts/install_zsh_macos.sh $GO_VER ;;
esac
