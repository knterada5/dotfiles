# Admin
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) { pwsh -NoProfile -ExecutionPolicy RemoteSigned -Command "Start-Process pwsh -Verb runas -ArgumentList '-ExecutionPolicy','RemoteSigned','$PSCommandPath'"; exit}

$RootDir = Split-Path -Path $PSScriptRoot

# Install software via winget
# Install sudo
winget install --id gerardog.gsudo --accept-source-agreements --accept-package-agreements

# Install iTunes
winget install --id 9PB2MZ1ZMB1S --accept-source-agreements --accept-package-agreements

# Install LINE
winget install --id XPFCC4CD725961 --accept-source-agreements --accept-package-agreements

# Install Wireless Adapter
winget install --id 9WZDNCRFJBB1 --accept-source-agreements --accept-package-agreements

# Install 7z
winget install --id 7zip.7zip --accept-source-agreements --accept-package-agreements

# Install JoyTokey
winget install --id JTKsoftware.JoyToKey --accept-source-agreements --accept-package-agreements

# Install Clip Studio
winget install --id XPDP32QDDFL4PK --accept-source-agreements --accept-package-agreements

# Install ESET Security
winget install --id ESET.Security --accept-source-agreements --accept-package-agreements

# Install Steam
winget install --id Valve.Steam --accept-source-agreements --accept-package-agreements

# Install Logi Options
winget install --id Logitech.OptionsPlus --accept-source-agreements --accept-package-agreements

# Install Remote mouse
winget install --id EmoteInteractive.RemoteMouse --accept-source-agreements --accept-package-agreements

# Install Virtual Box
winget install --id Oracle.VirtualBox --accept-source-agreements --accept-package-agreements

# Install Minecraft
winget install --id Mojang.MinecraftLauncher --accept-source-agreements --accept-package-agreements

# Install Android Studio
winget install --id Google.AndroidStudio --accept-source-agreements --accept-package-agreements

# Install Gimp
winget install --id GIMP.GIMP --accept-source-agreements --accept-package-agreements

# Install Inkscape
winget install --id Inkscape.Inkscape --accept-source-agreements --accept-package-agreements

# Install Thunderbird
winget install --id Mozilla.Thunderbird --accept-source-agreements --accept-package-agreements

# Install Blender
winget install --id BlenderFoundation.Blender --accept-source-agreements --accept-package-agreements

# Install Google Chrome
winget install --id Google.Chrome --accept-source-agreements --accept-package-agreements

# Install Vivaldi
winget install --id VivaldiTechnologies.Vivaldi --accept-source-agreements --accept-package-agreements

# Install VSCode
winget install --id Microsoft.VisualStudioCode --accept-source-agreements --accept-package-agreements

# Install Windows Terminal
winget install --id Microsoft.WindowsTerminal --accept-source-agreements --accept-package-agreements

# Install PowerToys
winget install --id Microsoft.PowerToys --accept-source-agreements --accept-package-agreements

# Install neovim
winget install --id Neovim.Neovim --accept-source-agreements --accept-package-agreements

# Install pyenv-win
Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"; &"./install-pyenv-win.ps1"
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# Install python 3.10.6 for Stable Diffusion
pyenv install 3.10.6
pyenv global 3.10.6

# Setting Path
$7Z = ";" + $env:Programfiles + "\7-Zip\"
$code = ";" + $HOME + "\AppData\Local\Programs\Microsoft VS Code\"
$PATH = $ENV:Path + $7Z + $code
[System.Environment]::SetEnvironmentVariable("Path", $PATH, "User")
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Setting alias python
rm $HOME\AppData\Local\Microsoft\WindowsApps\python.exe
if (-not (Test-Path $PROFILE)) {New-Item $PROFILE -Type File -Force}
Add-Content $PROFILE "Set-Alias -Name python -Value py"

# Download exe file and quiet install
# Download BandLab
Start-Process msedge https://www.bandlab.com/products/desktop/assistant/download/windows
Start-Sleep -Seconds 1
# Minimize vivalde
Add-Type -AssemblyName UIAutomationClient
$hwnd = (Get-Process | Where-Object {$_.MainWindowTitle -ne "" -and $_.ProcessName -like "*msedge*"}).MainWIndowHandle
$window = [System.Windows.Automation.AutomationElement]::FromHandle($hwnd)
$windowPattern=$window.GetCurrentPattern([System.Windows.Automation.WindowPattern]::Pattern)
$windowPattern.SetWindowVisualState([System.Windows.Automation.WindowVisualState]::Minimized)

# Install Fenrir FS
Invoke-WebRequest -Uri "https://www.fenrir-inc.com/services/download.php?file=FenrirFS-setup.exe" -OutFile "$HOME\Downloads\fenrir_installer.exe"
Start-Process -FilePath $HOME\Downloads\fenrir_installer.exe /SILENT -Wait

# Install vc2008 for MikuMikuDance
Invoke-WebRequest -Uri "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x64.exe" -OutFile "$HOME\Downloads\vc2008.exe"
Start-Process -FilePath $HOME\Downloads\vc2008.exe /q -Wait

# Install vcc2010 for MikuMikuDance
Invoke-WebRequest -Uri "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe" -OutFile "$HOME\Downloads\vc2010.exe"
Start-Process -FilePath $HOME\Downloads\vc2010.exe /q -Wait

# Install DirectX for MikuMikuDance
Invoke-WebRequest -Uri "https://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe" -OutFile "$HOME\Downloads\directx.exe"
mkdir $HOME\Downloads\directx
Start-Process -FilePath $HOME\Downloads\directx.exe /Q, /T:$HOME\Downloads\directx -Wait
Start-Process -FilePath $HOME\Downloads\directx\DXSETUP.exe /SILENT -Wait

# Install MMD
Invoke-WebRequest -Uri "https://drive.google.com/uc?id=1Iucxu0tDsD05Siyv8VBGgm9vjD-f-RhM&export=download" -OutFile "$HOME\Downloads\mmd.zip"
cd $env:Programfiles
mkdir FreeSoft
7z x $HOME\Downloads\mmd.zip -o"$env:Programfiles\FreeSoft"

# Unzip AviUtl
Invoke-WebRequest -Uri "http://spring-fragrance.mints.ne.jp/aviutl/aviutl110.zip" -OutFile "$HOME\Downloads\aviutl.zip"
cd $env:Programfiles
mkdir FreeSoft\AviUtl
7z x $HOME\Downloads\aviutl.zip -o"$env:Programfiles\FreeSoft\AviUtl"

# Install Nerd font
Invoke-WebRequest -Uri "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Noto.zip" -OutFile "$HOME\Downloads\noto.zip"
7z x $HOME\Downloads\noto.zip -o"$HOME\Downloads\noto"
$fonts_script = $RootDir + "\scripts\install_font.vbs"
cscript /nologo $fonts_script "$HOME\Downloads\noto\NotoMonoNerdFont-Regular.ttf"

# Setup config for windows terminal app
$WT_CONF = $RootDir + "\config\WindowsTerminal\settings.json"
New-Item -Value $WT_CONF -Path "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -ItemType SymbolicLink -Force

# Setup config for JoyTokey
$JOYTOKEY_CONF = $RootDir + "\config\JoyToky"
New-Item -Value $JOYTOKEY_CONF -Path $HOME\Documents\JoyTokey -ItemType SymbolicLink -Force

# Reload environment variable
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# Install VSCode extensions
$VSCode_ext = $RootDir + "\config\VSCode\extensions.json"
$VSCode_settings = $RootDir + "\config\VSCode\settings.json"
rm $HOME\.vscode\extensions\ -Recurse
New-Item -Value $VSCode_ext -Path $HOME\.vscode\extensions\extensions.json -ItemType SymbolicLink -Force
New-Item -Value $VSCode_settings -Path $HOME\AppData\Roaming\Code\User\settings.json -ItemType SymbolicLink -Force
sls '"identifier":{"id":".*?"' .\extensions.json -AllMatches | % {$_.Matches.Value} | % {$_ -replace '"identifier":{"id":"', ''} | % {$_ -replace '"', ''} | % {code --install-extension $_}

# Install Stable Diffusion
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git $HOME\StableDiffusion
python -m pip install --upgrade pip
cd $HOME\StableDiffusion
python -m venv venv
pip install xformers
$AutoLaunch = (gc $HOME\StableDiffusion\webui-user.bat) -replace "set COMMANDLINE_ARGS=", "set COMMANDLINE_ARGS=--autolaunch --medvram --xformers`r`n`r`n cd %~dp0"
$AutoLaunch > $HOME\StableDiffusion\webui-user.bat
cd $HOME\StableDiffusion
$SD = Start-Process -FilePath "$HOME\StableDiffusion\webui-user.bat" -PassThru
while (true) {
  if (Get-Process | Where-Object {$_.MainWindowTitle -like "*Stable Diffusion*"}) {
    Get-Process | Where-Object {$_.MainWindowTitle -like "*Stable Diffusion*"} | Stop-Process
    Stop-Process $SD.Id
    break
  }
  Start-Process -Seconds 30
}


# wsl --install
wsl --install -n

# Restart and run script after restart

# Run script after reboot
$script = $PSScriptRoot + "\scripts\install_software.ps1"
$pwsh = (gcm pwsh).Source
$regRunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
$restartKey = "Restart-And-RunOnce"
Set-ItemProperty -path $regRunOnceKey -name $restartKey -value "$pwsh -ExecutionPolicy RemoteSigned $script"

# Reboot
Restart-Computer -Force
