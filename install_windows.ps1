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


# Install Git
winget install --id Git.Git --accept-source-agreements --accept-package-agreements

git clone https://github.com/knterada5/.dotfiles.git $HOME\.dotfiles
. $HOME\.dotfiles\windows\scripts\setup.ps1