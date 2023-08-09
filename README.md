# Installation

## Linux
```
curl -LO https://raw.githubusercontent.com/knterada5/.dotfiles/main/install_linux.sh; source install_linux.sh
```

## Windows
```
Invoke-WebRequest -Uri https://raw.githubusercontent.com/knterada5/.dotfiles/main/install_windows.ps1 -OutFile $HOME\Downloads\install_windows.ps1; Start-Process PowerShell.exe -Verb runas ". $HOME\Downloads\install_windows.ps1"
```
