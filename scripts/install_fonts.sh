#!/bin/bash

if [ $# = 0 ]; then
  read -s -p "[sudo] password for $USER:" PSWD
else
  PSWD=$1
fi

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
ln -s $HOME/.dotfiles/fcitx $HOME/.config/fcitx

