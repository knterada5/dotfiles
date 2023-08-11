# Installation

## Linux
```
curl -LO https://raw.githubusercontent.com/knterada5/.dotfiles/main/install_linux.sh; source install_linux.sh
```

## Windows
Download [install_windows.bat](https://raw.githubusercontent.com/knterada5/.dotfiles/main/install_windows.ps1 download=\"start.bat\") and run.
```
Invoke-WebRequest -Uri https://raw.githubusercontent.com/knterada5/.dotfiles/main/install_windows.ps1 -OutFile $HOME\Downloads\install_windows.ps1; Start-Process pwsh "-File $HOME\Downloads\install_windows.ps1" -Verb RunAs
```
