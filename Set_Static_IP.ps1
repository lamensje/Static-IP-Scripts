﻿$MaskBits = 24
$IPType = "IPv4"

$adapter = Get-NetAdapter | Where-Object Name -NotLike "*vEthernet*" | Where-Object Name -Like "*Ethernet*"
$interface = $adapter | Get-NetIPInterface -AddressFamily "IPv4"
If (($interface | Get-NetIPConfiguration).IPv4Address.IPAddress) {
    $interface | Remove-NetIPAddress -AddressFamily $IPType -Confirm:$false
}
If (($interface | Get-NetIPConfiguration).Ipv4DefaultGateway) {
        $interface | Remove-NetRoute -Confirm:$false
}

echo ""
echo "Selected network adapter:" $adapter.InterfaceDescription
echo "" 

$IP= Read-Host -Prompt "Enter IP"

$result = $adapter | New-NetIPAddress `
 -AddressFamily $IPType `
 -IPAddress $IP `
 -PrefixLength $MaskBits
 
Start-Sleep 5
cmd /k ipconfig