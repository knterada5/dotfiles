#!/bin/zsh

# Arguments.
LOG=$1
GO_VER="1.20.3"

print "# Install packages." >> $LOG
print "1. asdf\n2. asdf-nodejs\n3. asdf-python\n4. neovim\n5. vim-jetpack\n6. GO\n7. lazygit" >> $LOG

# Make symbolic link
mv $HOME/.zshrc $HOME/.zshrc_bak
mv $HOME/.zsh_aliases $HOME/.zsh_aliases_bak
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/.zsh_aliases $HOME/.zsh_aliases
. $HOME/.zshrc

# Update repositories.
sudo -S apt update && sudo apt upgrade -y

# Install required packages for neovim.
sudo -S apt install ninja-build gettext cmake unzip curl -y

# Install required packages for python.
sudo -S apt install build-essential libbz2-dev libdb-dev libreadline-dev libffi-dev libgdbm-dev liblzma-dev libncursesw5-dev libsqlite3-dev libssl-dev zlib1g-dev uuid-dev tk-dev -y

# Install required packages for asdf-nodejs.
sudo -S apt install dirmngr gpg curl gawk -y

# Install asdf.
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3
. $HOME/.zshrc

print "\n# asdf version:" >> $LOG
asdf version >> $LOG


# Install asdf-nodejs.
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs latest
asdf global nodejs latest

print "\n# asdf-nodejs version:" >> $LOG
node -v >> $LOG

# Install asdf-python.
asdf plugin add python
asdf install python latest
asdf global python latest

print "\n# asdf-python version:" >> $LOG
python -V >> $LOG

# Clone and install neovim.
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
git checkout stable
sudo -S make install
cd $HOME

print "\n# neovim version:" >> $LOG
nvim -v >> $LOG

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

# Download Go.
GO_ARCH=true
case `uname -m | tr A-Z a-z` in
  "aarch64" | "arm64")
    ARCH="arm64" ;;
  "x86_64" | "x64" | "amd64")
    ARCH="amd64" ;;
  "x86")
    ARCH="386" ;;
  "ARMv6")
    ARCH="armv6l" ;;
  *)
    PS3="Select your architecture: "
    select word in 'x86' 'x86-64' 'ARM64' 'ARMv6' 'other'; do
      echo "Download go for $word"
      case $word in
        "x86")
          ARCH="386" ;;
        "x86-64")
          ARCH="amd64" ;;
        "ARM64")
          ARCH="arm64" ;;
        "ARMv6")
          ARCH="armv6l" ;;
        "other")
          echo "There is not GO install file."
          echo "Skip GO install."
          GO_ARCH=false
      esac
      break
    done
esac

# Download Go.
if $GO_ARCH ; then
  GO="go${GO_VER}.linux-${ARCH}.tar.gz"
  curl -o $HOME/go_install.tar.gz -L https://go.dev/dl/$GO

  # Decompress file.
  sudo -S tar -C /usr/local -xvzf go_install.tar.gz

  # Install lazygit via go.
  go install github.com/jesseduffield/lazygit@latest

  # Change go directory name.
  mv $HOME/go $HOME/.go

  print "\n# GO version:" >> $LOG
  go version >> $LOG

else
  cd $HOME
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
fi

print "\n# lazygit version:" >> $LOG
lazygit -v >> $LOG

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
