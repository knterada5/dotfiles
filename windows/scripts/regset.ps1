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