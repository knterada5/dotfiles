#!/bin/zsh

# Make symbolic link
mv $HOME/.zshrc $HOME/.zshrc_bak
mv $HOME/.zsh_aliases $HOME/.zsh_aliases_bak
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/.zsh_aliases $HOME/.zsh_aliases
. $HOME/.zshrc

# dotfiles directory.
DOTDIR=$(cd $(dirname $0); cd ..; pwd)

# Update repositories.
sudo -S apt update && sudo apt upgrade -y

# Install required packages.
while read line; do
  if [[ ! $line =~ "#" ]] && [[ ! -z $line ]]; then
    PACKS="$PACKS$line "
  fi
done < $DOTDIR/data/packages

CMD="sudo -S apt install -y $PACKS"
eval $CMD

# Install asdf.
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3
. $HOME/.zshrc

# Install Laguages.
zsh $DOTDIR/scripts/install_languages.sh

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
sudo -S rm -r $HOME/neovim

# Log of versions.
zsh $DOTDIR/scripts/log.sh >> $HOME/.installed_versions.log

# Set git config.
echo -n "Enter your git user.name: "
read USER_NAME
echo -n "Enter your git user.email: "
read USER_EMAIL
git config --global user.name "$USER_NAME"
git config --global user.email "$USR_EMAIL"
cd $HOME
