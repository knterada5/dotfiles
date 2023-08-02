$DNS = Get-DnsClientServerAddress | Where-Object {$_.InterfaceAlias -match "イーサネット$|Wi-Fi"} | Where-Object {$_.AddressFamily -match "^2$"} | select -ExpandProperty ServerAddresses | Sort-Object | Get-Unique

wsl --install ubuntu -n; ubuntu.exe run "./start_wsl.sh $DNS"
wsl --shutdown
ubuntu.exe