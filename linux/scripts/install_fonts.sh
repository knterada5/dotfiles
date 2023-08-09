#!/bin/bash

if [ $# = 0 ]; then
  if [[ $ZSH_EVAL_CONTEXT = toplevel ]]; then
    read -s "PSWD?[sudo] password for $USER: "
  else
    read -s -p "[sudo] password for $USER:" PSWD
  fi
  printf "\n"
else
  PSWD=$1
fi


# Dotfile directory
DOTDIR=$(cd $(dirname ${BASH_SOURCE:-$0}); cd ..; pwd)


echo $PSWD | sudo -S apt install -y language-selector-common
echo $PSWD | sudo -S apt install -y $(check-language-support -l ja)
echo $PSWD | sudo -S apt install -y fcitx-mozc
echo $PSWD | sudo -S apt install -y fonts-noto-color-emoji
echo $PSWD | sudo -S apt install -y fonts-symbola
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
./nerd-fonts/install.sh SourceCodePro
im-config -n fcitx
fcitx > /dev/null 2>&1 &
sleep 5
rm -rf $HOME/.config/fcitx
ln -s $DOTDIR/src/fcitx $HOME/.config/fcitx

