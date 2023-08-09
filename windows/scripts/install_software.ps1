$RootDir = Split-Path -Path $PSScriptRoot

# Set auto login false
$regLogonKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
Set-ItemProperty -path $regLogonKey -name "AutoAdminLogon" -value 0
Set-ItemProperty -path $regLogonKey -name "DefaultUsername" -value ""
Set-ItemProperty -path $regLogonKey -name "DefaultPassword" -value ""

# Restore PowerToys settings
mkdir $HOME\Documents\PowerToys\Backup
$PT_CONF = $PSScriptRoot + "\config\PowerToys\settings_*
New-Item -Path $PT_CONF -Destination "$HOME\Documents\PowerToys\Backup\" -ItemType SymbolickLink -Force
Start-Process $HOME\AppData\Local\PowerToys\PowerToys.exe
$wsobj = new-object -comobject wscript.shell
$result = $wsobj.popup("[全般]→[バックアップ&復元]→[復元]", 0, "PowerToys 設定の復元")

$POWERTOYS_WINDOW_TITLE = "*PowerToys*"
Add-Type -AssemblyName UIAutomationClient
$hwnd = (Get-Process |?{$_.MainWindowTitle -like $POWERTOYS_WINDOW_TITLE})[0].MainWindowHandle
$window = [System.Windows.Automation.AutomationElement]::FromHandle($hwnd)
$windowPattern=$window.GetCurrentPattern([System.Windows.Automation.WindowPattern]::Pattern)

while ($true) {
  if ($windowPattern.Current.WindowVisualState -eq 'Minimized')
  {
    break
  }
  Start-Sleep -Seconds 1
}


# Install cakewalk
Start-Process -FilePath $HOME\Downloads\BandLab*

Start-Sleep -Seconds 30

while ($true) {
  $BAND = Get-Process | Where-Object {$_.MainWindowTitle -ne ""} | Select-Object MainWindowTitle | Select-String "BandLab"
  if ($BAND -eq $null)
  {
    echo "owata"
    break
  }
  else
  {
    echo "madaya"
  }
  Start-Sleep -Seconds 5
}


# Setup Ubuntu on wsl
cd $PSScriptRoot
$DNS=Get-DnsClientServerAddress | Where-Object {$_.InterfaceAlias -match "イーサネット$|Wi-Fi"} | Where-Object {$_.AddressFamily -match "^2$"} | select -ExpandProperty ServerAddresses | Sort-Object | Get-Unique
wsl --install ubuntu -n; ubuntu run "./start_wsl.sh $DNS"


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