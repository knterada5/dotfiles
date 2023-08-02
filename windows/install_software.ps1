# Set auto login false
$regLogonKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
Set-ItemProperty -path $regLogonKey -name "AutoAdminLogon" -value 0
Set-ItemProperty -path $regLogonKey -name "DefaultUsername" -value ""
Set-ItemProperty -path $regLogonKey -name "DefaultPassword" -value ""

# Restore PowerToys settings
mkdir $HOME\Documents\PowerToys\Backup
$PT_CONF = $PSScriptRoot + "\config\PowerToys\settings_*
Copy-Item -Path $PT_CONF -Destination "$HOME\Documents\PowerToys\Backup\" -ItemType SymbolickLink -Force
Start-Process $HOME\AppData\Local\PowerToys\PowerToys.exe


# Install cakewalk
Start-Process -FilePath $HOME\Downloads\BandLab*

# Setup Ubuntu on wsl
cd $PSScriptRoot
$DNS=Get-DnsClientServerAddress | Where-Object {$_.InterfaceAlias -match "イーサネット$|Wi-Fi"} | Where-Object {$_.AddressFamily -match "^2$"} | select -ExpandProperty ServerAddresses | Sort-Object | Get-Unique
wsl --install -n; ubuntu run "bash --login


# Setting Hotkey
mkdir "$HOME\AppData\Roaming\Microsoft\Windows\Start Menu\Shortcut"
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WsShell.CreateShortcut('AppData\Roaming\Microsoft\Windows\Start Menu\Shortcut\ubuntu.lnk')
$Shortcut.TargetPath = "ubuntu"
$Shortcut.Hotkey = "ALT+CTRL+U"
$Shortcut.Save()

$Shortcut = $WsShell.CreateShortcut('AppData\Roaming\Microsoft\Windows\Start Menu\Shortcut\pwsh.lnk')
$Shortcut.TargetPath = "pwsh"
$Shortcut.Hotkey = "ALT+CTRL+P"
$Shortcut.Save()