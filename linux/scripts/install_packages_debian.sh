#!/bin/zsh

if [ $# = 0 ]; then
  read -s "PSWD?[sudo] password for $USER:" PSWD
else
  PSWD=$1
  USER_NAME=$2
  USER_EMAIL=$3
fi

# dotfiles directory.
DOTDIR=$(cd $(dirname ${BASH_SOURCE:-$0}); cd ..; pwd)

# Make symbolic link
mv $HOME/.zshrc $HOME/.zshrc_bak
mv $HOME/.zsh_aliases $HOME/.zsh_aliases_bak
ln -s $DOTDIR/src/.zshrc $HOME/.zshrc
ln -s $DOTDIR/src/.zsh_aliases $HOME/.zsh_aliases
. $HOME/.zshrc


# Update repositories.
echo $PSWD | sudo -S apt update && sudo apt upgrade -y

# Install required packages.
while read line; do
  if [[ ! $line =~ "#" ]] && [[ ! -z $line ]]; then
    echo $PSDW | sudo -S apt install -y $line
  fi
done < $DOTDIR/data/packages

# Set git config.
git config --global user.name "$USER_NAME"
git config --global user.email "$USER_EMAIL"

# Install asdf.
git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.11.3
. $HOME/.zshrc

# Install Laguages.
. $DOTDIR/scripts/install_languages.sh

# Clone and install neovim.
git clone https://github.com/neovim/neovim $HOME/neovim
cd $HOME/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
git checkout stable
echo $PSWD | sudo -S make install
cd $HOME

# Install NvChad
git clone https://github.com/NvChad/NvChad $HOME/.config/nvim --depth 1 && nvim --headless +q
rm -rf $HOME/.config/nvim/lua/custom
ln -s $DOTDIR/src/custom $HOME/.config/nvim/lua/custom
nvim --headless +q
cd $HOME

# Install LSP via Mason
nvim --headless +"MasonInstallAll" +q

# Install lazygit via go.
go install github.com/jesseduffield/lazygit@latest
asdf reshim golang

# Remove install file.
echo $PSWD | sudo -S rm -r $HOME/neovim

# List of packages version.
. $DOTDIR/scripts/log.sh >> $HOME/installed_versions.log
