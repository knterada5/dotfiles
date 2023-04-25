#!/bin/bash

# GO latest version.
GO_VER="1.20.3"

# OS
OS=`uname | tr A-Z a-z`
DIR=$(cd $(dirname $0); pwd)

case $OS in
  "linux")
    . $DIR/scripts/install_linux.sh $GO_VER ;;
  "darwin")
    . $DIR/scripts/install_macos.sh $GO_VER ;;
esac
