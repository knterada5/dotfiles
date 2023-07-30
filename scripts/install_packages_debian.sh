#!/bin/zsh

if [ $# == 0 ]; then
  read -s -p "[sudo] password for $USER:" PSWD
else
  PSWD=$1
fi

# Make symbolic link
mv $HOME/.zshrc $HOME/.zshrc_bak
mv $HOME/.zsh_aliases $HOME/.zsh_aliases_bak
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/.zsh_aliases $HOME/.zsh_aliases
. $HOME/.zshrc

# dotfiles directory.
DOTDIR=$(cd $(dirname $0); cd ..; pwd)

# Update repositories.
echo $PSWD | sudo -S apt update && sudo apt upgrade -y

# Install required packages.
while read line; do
  if [[ ! $line =~ "#" ]] && [[ ! -z $line ]]; then
    echo $PSDW | sudo -S apt install -y $line
  fi
done < $DOTDIR/data/packages

# Install asdf.
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3
. $HOME/.zshrc

# Install Laguages.
zsh $DOTDIR/scripts/install_languages.sh

# Clone and install neovim.
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
git checkout stable
echo $PSWD | sudo -S make install
cd $HOME

# Install NvChad
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
rm -rf $HOME/.config/nvim/lua/custom
ln -s $HOME/.dotfiles/custom $HOME/.config/nvim/lua/custom
cd $HOME

# Install lazygit via go.
go install github.com/jesseduffield/lazygit@latest
asdf reshim golang

# Install LSP via Mason
nvim --headless +"MasonInstallAll" +q

# Remove install file.
echo $PSWD | sudo -S rm -r $HOME/neovim

# Log of versions.
zsh $DOTDIR/scripts/log.sh >> $HOME/.installed_versions.log

# Install fonts
cd $HOME
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
./nerd-fonts/install.sh SourceCodePro

# Setting IME
im-config -n fcitx
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export DefaultIMModule=fcitx
fcitx-autostart > /dev/null 2>&1 &
sleep 10
rm -r $HOME/.config/fcitx
ln -s $HOME/.dotfiles/fcitx $HOME/.config/fcitx

# Set git config.
read -p "Enter your git user.name:" USER_NAME
read -p "Enter your git user.email:" USER_EMAIL
git config --global user.name "$USER_NAME"
git config --global user.email "$USR_EMAIL"
sudo reboot
exit
