# Admin
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) { pwsh -NoProfile -ExecutionPolicy RemoteSigned -Command "Start-Process pwsh -Verb runas -ArgumentList '-ExecutionPolicy','RemoteSigned','$PSCommandPath'"; exit}

$RootDir = Split-Path -Path $PSScriptRoot


# Install software via winget
cd $PSScriptRoot
. .\winget.ps1

# Install FinchTV
Invoke-WebRequest -Uri "https://digitalworldbiology.com/sites/default/files/Basic%20page/upfiles/Windows_FinchTV_1_4_0.zip" -OutFile "$HOME\Downloads\finchtv.zip"
7z x $HOME\Downloads\finchtv.zip -o"$HOME\Downloads\finchtv"
Start-Process msiexec.exe -ArgumentList "/i `"$HOME\Downloads\finchtv\FinchTV_1_4_0\installer.msi`" /passive" -NoNewWindow -Wait

# Install FluorCam7
Invoke-WebRequest -Uri "https://fluorcams.psi.cz/documents//Fluorcam7setup.exe" -OutFile "$HOME\Downloads\fluorcam_installer.exe"
Start-Process -FilePath $HOME\Downloads\fluorcam_installer.exe -ArgumentList "/passive" -Wait

# Install Jalview
Invoke-WebRequest -Uri "https://www.jalview.org/getdown/release/install4j/1.8/Jalview-2_11_2_0-windows-x64-java_8.exe" -OutFile "$HOME\Downloads\jalview_installer.exe"
Start-Process -FilePath $HOME\Downloads\jalview_installer.exe -ArgumentList "-q" -Wait

# Install JBrowse2
Invoke-WebRequest -Uri "https://github.com/GMOD/jbrowse-components/releases/download/v2.6.3/jbrowse-desktop-v2.6.3-win.exe" -OutFile "$HOME\Downloads\jbrowse_installer.exe"
Start-Process -FilePath $HOME\Downloads\jbrowse_installer.exe -Wait

# Install Fenrir FS
Invoke-WebRequest -Uri "https://www.fenrir-inc.com/services/download.php?file=FenrirFS-setup.exe" -OutFile "$HOME\Downloads\fenrir_installer.exe"
Start-Process -FilePath $HOME\Downloads\fenrir_installer.exe -ArgumentList "/SILENT" -Wait

# Install Nerd font
Invoke-WebRequest -Uri "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Noto.zip" -OutFile "$HOME\Downloads\noto.zip"
7z x $HOME\Downloads\noto.zip -o"$HOME\Downloads\noto"
$fonts_script = $RootDir + "\scripts\install_font.vbs"
cscript /nologo $fonts_script "$HOME\Downloads\noto\NotoMonoNerdFont-Regular.ttf"

# wsl --install
wsl --install -n

# Set up Config
# Setup config for windows terminal app
$WT_CONF = $RootDir + "\config\WindowsTerminal\settings.json"
New-Item -Value $WT_CONF -Path "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -ItemType SymbolicLink -Force

# Install VSCode extensions and set up config
$VSCode_ext = $RootDir + "\config\VSCode\extensions.json"
$VSCode_settings = $RootDir + "\config\VSCode\settings.json"
rm $HOME\.vscode\extensions\ -Recurse
New-Item -Value $VSCode_settings -Path $HOME\AppData\Roaming\Code\User\settings.json -ItemType SymbolicLink -Force
New-Item -Value $VSCode_ext -Path $HOME\.vscode\extensions\extensions.json -ItemType SymbolicLink -Force
sls '"identifier":{"id":".*?"' $VSCode_ext -AllMatches | % {$_.Matches.Value} | % {$_ -replace '"identifier":{"id":"', ''} | % {$_ -replace '"', ''} | % {& $HOME\AppData\Local\Programs\'Microsoft VS Code'\bin\code.cmd --install-extension $_}

# Setting Hotkey
$WsShell = New-Object -ComObject WScript.Shell
mkdir "$HOME\AppData\Roaming\Microsoft\Windows\Start Menu\Shortcut"
$Ubuntu_Shc = $WsShell.CreateShortcut("$HOME\AppData\Roaming\Microsoft\Windows\Start Menu\Shortcut\ubuntu.lnk")
$Ubuntu_Shc.TargetPath = "ubuntu"
$Ubuntu_Shc.HotKey = "ALT+CTRL+U"
$Ubuntu_Shc.Save()

$Pwsh_Shc = $WsShell.CreateShortcut("$HOME\AppData\Roaming\Microsoft\Windows\Start Menu\Shortcut\pwsh.lnk")
$Pwsh_Shc.TargetPath = "pwsh"
$Pwsh_Shc.Hotkey = "ALT+CTRL+P"
$Pwsh_Shc.Save()

# Change Registry
cd $PSScriptRoot
. .\regset.ps1

# Restart and run script after restart
$script = $RootDir + "\scripts\after_reboot.ps1"
$pwsh = (gcm pwsh).Source
$regRunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
$restartKey = "Restart-And-RunOnce"
Set-ItemProperty -path $regRunOnceKey -name $restartKey -value "$pwsh -ExecutionPolicy RemoteSigned $script"
Restart-Computer -Force
