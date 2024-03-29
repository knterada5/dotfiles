# Admin
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) { powershell -NoProfile -ExecutionPolicy RemoteSigned -Command "Start-Process powershell -Verb runas -ArgumentList '-ExecutionPolicy','RemoteSigned','$PSCommandPath'"; exit}


# Set Auto login
$defaultUserName = $env:username
echo "The information below is only used for login to reboot"
$UserPassword = Read-Host "Enter your account password (not PIN): " -AsSecureString
$GitName = Read-Host "Enter your name for git: "
$GitEmai = Read-Host "Enter your email address for git: "
$bstrUserPassword = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($UserPassword)
$defaultPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstrUserPassword)

$regLogonKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
Set-ItemProperty -path $regLogonKey -name "AutoAdminLogon" -value 1
Set-ItemProperty -path $regLogonKey -name "DefaultUsername" -value $defaultUserName
Set-ItemProperty -path $regLogonKey -name "DefaultPassword" -value $defaultPassword


# Install winget
$OS_Ver = (Get-WmiObject Win32_OperatingSystem).Version | % { $_ -creplace "^.*\.", "" }
if (-not (gcm winget -ea SilentlyContinue)) {
  if ($OS_Ver -ge 16299) {
    echo "Install winget."
    Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe 
  }
  else {
    echo "Your machine is lower than Windows 10 1709."
    echo "Exit."
    pause
    exit
  }
}

If (-not (gcm winget -ea SilentlyContinue)) {
  echo "Failed install winget."
  echo "Exit."
  pause
  exit
}


# Install pwsh
if (-not (gcm pwsh -ea SilentlyContinue)) {
  echo "Install pwsh."
  winget install --id Microsoft.PowerShell --accept-source-agreements --accept-package-agreements
}


# Install Git
echo "Install Git."
winget install --id Git.Git --accept-source-agreements --accept-package-agreements

# Reload environment variable
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# Clone dotfiles and set up
git config --global core.autocrlf false
git config --global user.name $GitName
git config --global user.email $GitEmai
git clone https://github.com/knterada5/dotfiles.git $HOME\.dotfiles
$pcname = hostname
takeown /s $pcname /F $HOME\.dotfiles /R 
pwsh $HOME\.dotfiles\windows\scripts/setup.ps1
