$RootDir = Split-Path -Path $PSScriptRoot

$defaultUserName = Read-Host "名前を入力してください"
$UserPassword = Read-Host "パスワードを入力してください" -AsSecureString
$bstrUserPassword = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($UserPassword)
$defaultPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstrUserPassword)

# Install winget
if (-not (gcm winget -ea SilentlyContinue)) {
    cd $HOME\Downloads
    Invoke-WebRequest -Uri "https://github.com/microsoft/winget-cli/releases/download/v1.5.1881/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -OutFile "$HOME\Downloads\winget.msixbundle"
    # Install Microsoft.UI.Xaml.2.7
    Invoke-WebRequest -Uri "https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.7.0" -OutFile "$HOME\Downloads\Microsoft.UI.Xaml.2.7.nupkg.zip"
    Expand-Archive Microsoft.UI.Xaml.2.7.nupkg.zip
    Add-AppxPackage .\Microsoft.UI.Xaml.2.7.nupkg\tools\AppX\x64\Release\Microsoft.UI.Xaml.2.7.appx
    # Install VCLibs
    Invoke-WebRequest -Uri  https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx  -OutFile "$HOME\Downloads\Microsoft.VCLibs.x64.14.00.Desktop.appx"
    Add-AppxPackage .\Microsoft.VCLibs.x64.14.00.Desktop.appx
    Add-appPackage -Path .\winget.msixbundle
}

# Install software via winget
# Install sudo
winget install --id gerardog.gsudo --accept-source-agreements --accept-package-agreements

# Install iTunes
winget install --id 9PB2MZ1ZMB1S --accept-source-agreements --accept-package-agreements

# Install LINE
winget install --id XPFCC4CD725961 --accept-source-agreements --accept-package-agreements

# Install PowerShell
winget install --id 9MZ1SNWT0N5D --accept-source-agreements --accept-package-agreements

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

# Install Vagrant
winget install --id Hashicorp.Vagrant --accept-source-agreements --accept-package-agreements

# Install Minecraft
winget install --id Mojang.MinecraftLauncher --accept-source-agreements --accept-package-agreements

# Install Git
winget install --id Git.Git --accept-source-agreements --accept-package-agreements

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


# Download exe file and quiet install
# Download BandLab
Start-Process vivaldi https://www.bandlab.com/products/desktop/assistant/download/windows
# Minimize vivalde
$MAIN_WINDOW_TITLE = "*Vivaldi*"
Add-Type -AssemblyName UIAutomationClient
$hwnd = (Get-Process |?{$_.MainWindowTitle -like $MAIN_WINDOW_TITLE})[0].MainWindowHandle
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
sudo mkdir FreeSoft
cd FreeSoft
7z x $HOME\Downloads\mmd.zip

# Unzip AviUtl
Invoke-WebRequest -Uri "http://spring-fragrance.mints.ne.jp/aviutl/aviutl110.zip" -OutFile "$HOME\Downloads\aviutl.zip"
cd $env:Programfiles
sudo mkdir FreeSoft
cd FreeSoft
mkdir AviUtl
cd AviUtl
7z x $HOME\Downloads\aviutl.zip

# Install Nerd font
Invoke-WebRequest -Uri "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Noto.zip" -OutFile "$HOME\Downloads\noto.zip"
mkdir noto
cd noto
7z x $HOME\Downloads\noto.zip
$fonts_script = $RootDir + "scripts\install_font.vbs"
cscript /nologo $fonts_script "$HOME\Downloads\noto\NotoMonoNerdFont-Regular.ttf"


# Setup config for windows terminal app
$WT_CONF = $RootDir + "\config\WindowsTerminal\settings.json"
New-Item -Value $WT_CONF -Path "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -ItemType SymbolicLink -Force


# wsl --install
wsl --install

# Restart and run script after restart


# Set Auto login
$regLogonKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
Set-ItemProperty -path $regLogonKey -name "AutoAdminLogon" -value 1
Set-ItemProperty -path $regLogonKey -name "DefaultUsername" -value $defaultUserName
Set-ItemProperty -path $regLogonKey -name "DefaultPassword" -value $defaultPassword


# Run script after reboot
$script = $PSScriptRoot + "\install_software.ps1"
$regRunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
$powerShell = where.exe powershell.exe
$restartKey = "Restart-And-RunOnce"
Set-ItemProperty -path $regRunOnceKey -name $restartKey -value "sudo pwsh -ExecutionPolicy RemoteSigned $script"


# Reboot
Restart-Computer -Force