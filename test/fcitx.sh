#/bin/bash

echo "export QT_IM_MODULE=fcitx" >> $HOME/.bashrc
echo "export GTK_IM_MODULE=fcitx" >> $HOME/.bashrc
echo "export XMODIFIERS=@im=fcitx" >> $HOME/.bashrc
echo "export DefaultIMModule=fcitx" >> $HOME/.bashrc
echo "fcitx > /dev/null 2>&1 &" >> $HOME/.bashrc
echo "fcitx-autostart > /dev/null 2>&1 &" >> $HOME/.bashrc

sudo apt install -y language-selector-common
sudo apt install -y $(check-language-support -l ja) fcitx-mozc
sudo apt install -y fonts-noto-color-emoji
sudo apt install -y fonts-symbola
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
./nerd-fonts/install.sh SourceCodePro
im-config -n fcitx
fcitx > /dev/null 2>&1 &
sleep 5
rm $HOME/.config/fcitx/profile $HOME/.config/fcitx/config
ln -s $HOME/.dotfiles/fcitx/profile $HOME/.config/fcitx/profile
ln -s $HOME/.dotfiles/fcitx/config $HOME/.config/fcitx/config
exit
