# Install software via winget

# Install sudo
winget install --id gerardog.gsudo --accept-source-agreements --accept-package-agreements

# Install 7z
winget install --id 7zip.7zip --accept-source-agreements --accept-package-agreements

# Install Virtual Box
winget install --id Oracle.VirtualBox --accept-source-agreements --accept-package-agreements

# Install Gimp
winget install --id GIMP.GIMP --accept-source-agreements --accept-package-agreements

# Install Inkscape
winget install --id Inkscape.Inkscape --accept-source-agreements --accept-package-agreements

# Install Thunderbird
winget install --id Mozilla.Thunderbird --accept-source-agreements --accept-package-agreements

# Install Google Chrome
winget install --id Google.Chrome --accept-source-agreements --accept-package-agreements

# Install VSCode
winget install --id Microsoft.VisualStudioCode --accept-source-agreements --accept-package-agreements

# Install Windows Terminal
winget install --id Microsoft.WindowsTerminal --accept-source-agreements --accept-package-agreements

# Install lazygit
winget install --id JesseDuffield.lazygit --accept-source-agreements --accept-package-agreements

# Install PowerToys
winget install --id Microsoft.PowerToys --accept-source-agreements --accept-package-agreements

# Install Zoom
winget install --id Zoom.Zoom --accept-source-agreements --accept-package-agreements

# Setting Path
$7Z = ";" + $env:Programfiles + "\7-Zip\"
$code = ";" + $HOME + "\AppData\Local\Programs\Microsoft VS Code\"
$PATH = $ENV:Path + $7Z + $code
[System.Environment]::SetEnvironmentVariable("Path", $PATH, "User")
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")