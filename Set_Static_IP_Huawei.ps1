$MaskBits = 24
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

$IP= "192.168.8.69"

$result = $adapter | New-NetIPAddress `
 -AddressFamily $IPType `
 -IPAddress $IP `
 -PrefixLength $MaskBits
 
start "https://192.168.8.10" 
Start-Sleep 5
cmd /k ipconfig