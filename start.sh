#!/bin/bash

# Make symbolic link
mv $HOME/.bashrc $HOME/.bashrc_bak
mv $HOME/.profile $HOME/.profile_bak
ln -s $HOME/.dotfiles/.bashrc $HOME/.bashrc
ln -s $HOME/.dotfiles/.profile $HOME/.profile

# Update repositories.
sudo apt update && sudo apt upgrade -y

# Install required packages for neovim.
sudo apt install ninja-build gettext cmake unzip curl -y

# Install required packages for python.
sudo apt install build-essential libbz2-dev libdb-dev libreadline-dev libffi-dev libgdbm-dev liblzma-dev libncursesw5-dev libsqlite3-dev libssl-dev zlib1g-dev uuid-dev tk-dev -y

# Install required packages for asdf-nodejs.
sudo apt install dirmngr gpg curl gawk -y

# Install asdf.
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3
source $HOME/.profile

# Install asdf-nodejs.
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs latest
asdf global nodejs latest

# Install asdf-python.
asdf plugin add python
asdf install python latest
asdf global python latest

# Clone and install neovim.
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
git checkout stable
sudo make install

# Make nvim config.
cd $HOME
mkdir $HOME/.config
ln -s $HOME/.dotfiles/nvim ~/.config/nvim

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
sudo rm $HOME/go1.20.3.linux-amd64.tar.gz
sudo rm -r $HOME/neovim

# Set git config.
cd $HOME/.dotfiles
echo -n "Enter your git user.name: "
read USER_NAME
echo -n "Enter your git user.email: "
read USER_EMAIL
git config --local user.name "$USER_NAME"
git config --local user.email "$USR_EMAIL"
