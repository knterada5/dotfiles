function RegSet {
    param (
        $RegPath,
        $RegKey,
        $RegKeyType,
        $RegKeyValue
    )
    $Elements = $RegPath -split "\\"
    $RegPath = ""
    $First = $true
    foreach ($Element in $Elements) {
        if($First) {
            $First = $false
        }
        else {
            $RegPath += "\"
        }
        $RegPath += $Element
        if( -not (Test-Path $RegPath) ) {
            mkdir $RegPath
        }
    }

    $Result = Get-ItemProperty $RegPath -Name $RegKey -ErrorAction SilentlyContinue
    if ($null -ne $Result) {
        Set-ItemProperty $RegPath -Name $RegKey -Value $RegKeyValue
    }
    else {
        New-ItemProperty $RegPath -Name $RegKey -PropertyType $RegKeyType -Value $RegKeyValue
    }
}

RegSet "HKCU:\Software\Microsoft\IME\15.0\IMEJP\MSIME" "IsKeyAssignmentEnabled" 'DWord' 1
RegSet "HKCU:\Software\Microsoft\IME\15.0\IMEJP\MSIME" "KeyAssignmentMuhenkan" 'DWord' 1
RegSet "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" "{645FF040-5081-101B-9F08-00AA002F954E}" 'DWord' 1
RegSet "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" "SearchboxTaskbarMode" 'DWord' 0
RegSet "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowTaskViewButton" 'DWord' 0
RegSet "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarMn" 'DWord' 0
RegSet "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarDa" 'DWord' 0
RegSet "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" "ShowFrequent" 'DWord' 0
RegSet "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" "ShowRecent" 'DWord' 0
RegSet "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" "ShowFrequent" 'DWord' 0
RegSet "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideDrivesWithNoMedia" 'DWord' 0
RegSet "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Hidden" 'DWord' 1
RegSet "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" 'DWord' 0
RegSet "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "NavPaneShowAllFolders" 'DWord' 1
RegSet "HKCU:\Software\Microsoft\Windows\CurrentVersion\Start" "ShowFrequentList" 'DWord' 0
RegSet "HKCU:\Software\Microsoft\Windows\CurrentVersion\Start" "ShowRecentList" 'DWord' 0
RegSet "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Start_IrisRecommendations" 'DWord' 0
RegSet "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Start_TrackDocs" 'DWord' 0
RegSet "HKCU:\Software\Microsoft\Windows\CurrentVersion\Start" "VisiblePlaces" 'DWord' 0
RegSet "HKCU:\Control Panel\Desktop" "ImageColor" 'DWord' 3305111551
RegSet "HKCU:\Control Panel\Desktop" "WallPaper" 'String' ""
RegSet "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers" "BackgroundType" 'DWord' 1
RegSet "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "SystemUsesLightTheme" 'DWord' 0
RegSet "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "AppsUseLightTheme" 'DWord' 0
