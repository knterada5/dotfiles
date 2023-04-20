#!/bin/bash

# Make symbolic link
mv $HOME/.bashrc $HOME/.bashrc_bak
mv $HOME/.profile $HOME/.profile_bak
ln -s $HOME/.dotfiles/.bashrc $HOME/.bashrc
ln -s $HOME/.dotfiles/.profile $HOME/.profile
source $HOME/.profile
source $HOME/.bashrc

# Update repositories.
sudo apt update && sudo apt upgrade -y

# Install required packages for neovim.
sudo apt install ninja-build gettext cmake unzip curl -y

# Clone and install neovim
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
git checkout stable
sudo make install

# Make nvim config.
mkdir ~/.config
ln -s ~/.dotfiles/nvim ~/.config/nvim

# Install vim-jetpack.
curl -fLo ~/.local/share/nvim/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim

# Download Go.
wget https://go.dev/dl/go1.20.3.linux-amd64.tar.gz

# Decompress file.
sudo tar -C /usr/local -xzf go1.20.3.linux-amd64.tar.gz

# Install lazygit via go.
go install github.com/jesseduffield/lazygit@latest

# Change go directory name.
mv $HOME/go $HOME/.go

# Remove install file.
rm $HOME/go1.20.3.linux-amd64.tar.gz
rm -r $HOME/neovim

# Set git config.
cd $HOME/.dotfiles
echo -n "Enter your git user.name: "
read USER_NAME
echo -n "Enter your git user.email: "
read USER_EMAIL
git config --local user.name "$USER_NAME"
git config --local user.email "$USR_EMAIL"
