Param (
    [switch]$PowerToys,
    [switch]$Terminal,
    [switch]$VSCode
)

function update_PT {
    $LatestPowerToys = (ls C:\Users\knterada5\Documents\PowerToys\Backup\settings_*.ptb | Sort-Object LastWriteTime -Descending)[0].FullName
    rm $HOME\.dotfiles\windows\config\PowerToys\*
    Copy-Item $LatestPowerToys -Destination $HOME\.dotfiles\windows\config\PowerToys -Force
}

function update_WT {
    Copy-Item $HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Destination $HOME\.dotfiles\windows\config\WindowsTerminal -Force
}

function update_VSC {
    Copy-Item $HOME\AppData\Roaming\Code\User\settings.json -Destination $HOME\.dotfiles\windows\config\VSCode -Force
    sls '"identifier":{"id":".*?"' $HOME\.vscode\extensions\extensions.json -AllMatches | % {$_.Matches.Value} | % {$_ -replace '"identifier":{"id":"', ''} | % {$_ -replace '"', ''} > $HOME\.dotfiles\windows\config\VSCode\extensions
}

if ((! $PowerToys) -and (! $Terminal) -and (! $VSCode)) {
    update_PT
    update_VSC
    update_WT
    echo "All"
} else {
    if ($PowerToys) {
        update_PT
        echo "PowerToys"
    }
    if ($Terminal) {
        update_WT
        echo "Terminal"
    }
    if ($VSCode) {
        update_VSC
        echo "VSCode"
    }
}

echo "Powrtoys: $PowerToys"
echo "Terminal: $Terminal"
echo "VSCode: $VSCode"
Pause