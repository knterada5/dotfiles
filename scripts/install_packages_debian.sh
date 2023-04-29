#!/bin/zsh

# Make symbolic link
mv $HOME/.zshrc $HOME/.zshrc_bak
mv $HOME/.zsh_aliases $HOME/.zsh_aliases_bak
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/.zsh_aliases $HOME/.zsh_aliases
. $HOME/.zshrc

# dotfiles directory.
DIR=$(cd $(dirname $0); pwd)

# Update repositories.
sudo -S apt update && sudo apt upgrade -y

# Install required packages for neovim.
sudo -S apt install ninja-build gettext cmake unzip curl -y

# Install required packages for python.
sudo -S apt install build-essential libbz2-dev libdb-dev libreadline-dev libffi-dev libgdbm-dev liblzma-dev libncursesw5-dev libsqlite3-dev libssl-dev zlib1g-dev uuid-dev tk-dev -y

# Install required packages for asdf-nodejs.
sudo -S apt install dirmngr gpg curl gawk -y

sudo -S apt install build-essential libcurl3-dev libreadline-dev gfortran
sudo -S apt install liblzma-dev liblzma5 libbz2-1.0 libbz2-dev
sudo -S apt install xorg-dev libbz2-dev liblzma-dev libpcre2-dev

# Install asdf.
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3
. $HOME/.zshrc

# Install asdf-nodejs.
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs latest
asdf global nodejs latest

# Install asdf-python.
asdf plugin add python
asdf install python latest
asdf global python latest

# Install asdf-lua.
asdf plugin add lua
asdf install lua latest
asdf global lua latest

# Install asdf-golang.
asdf plugin add golang
asdf install golang latest
asdf global golang latest

# Install asdf-r
asdf plugin add rlang https://github.com/asdf-community/asdf-r.git
asdf install rlang latest
asdf global rlang latest

# Install asdf-kotlin.
asdf plugin add kotlin
asdf install kotlin latest
asdf global kotlin latest

# Install asdf-php
autoconf bison build-essential curl gettext git libgd-dev libcurl4-openssl-dev libedit-dev libicu-dev libjpeg-dev libmysqlclient-dev libonig-dev libpng-dev libpq-dev libreadline-dev libsqlite3-dev libssl-dev libxml2-dev libzip-dev openssl pkg-config re2c zlib1g-dev
asdf plugin add php
asdf install php latest
asdf global php latest

# Clone and install neovim.
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
git checkout stable
sudo -S make install
cd $HOME

# Make nvim config.
mkdir $HOME/.config
ln -s $HOME/.dotfiles/nvim ~/.config/nvim

# Install pynvim
cd $HOME/.config/nvim
pip3 install --upgrade pip
pip3 install pipenv
python -m pipenv --python 3
sudo -S $HOME/.config/nvim/.venv/bin/python3 -m pip install pynvim
cd $HOME

# Install vim-jetpack.
curl -fLo ~/.local/share/nvim/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim
mv $HOME/.config/nvim/init.lua $HOME/.config/nvim/_init.lua
mv $HOME/.config/nvim/init_init.lua $HOME/.config/nvim/init.lua
nvim
mv $HOME/.config/nvim/init.lua $HOME/.config/nvim/init_init.lua
mv $HOME/.config/nvim/_init.lua $HOME/.config/nvim/init.lua

# Install lazygit via go.
go install github.com/jesseduffield/lazygit@latest

# Change go directory name.
mv $HOME/go $HOME/.go

# Remove install file.
sudo -S rm $HOME/go1.20.3.linux-amd64.tar.gz
sudo -S rm -r $HOME/neovim
sudo -S rm -r $HOME/lazygit
sudo -S rm $HOME/lazygit.tar.gz

# Set git config.
cd $HOME
echo -n "Enter your git user.name: "
read USER_NAME
echo -n "Enter your git user.email: "
read USER_EMAIL
git config --global user.name "$USER_NAME"
git config --global user.email "$USR_EMAIL"
cd $HOME

