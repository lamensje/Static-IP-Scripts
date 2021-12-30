$adapter = Get-NetAdapter | Where-Object Name -NotLike "*vEthernet*" | Where-Object Name -Like "*Ethernet*"
echo "Selected network adapter:" $adapter.InterfaceDescription
echo ""
$interface = $adapter | Get-NetIPInterface -AddressFamily "IPv4"
echo "DHCP is currently:" $interface.Dhcp

If ($interface.Dhcp -eq "Disabled") {
    echo ""
    echo "Static IP Was: " ($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress
    If (($interface | Get-NetIPConfiguration).Ipv4DefaultGateway) {
        $interface | Remove-NetRoute -Confirm:$false -ErrorAction SilentlyContinue
    }
    echo ""
    echo "Enabling DHCP now"
    $interface | Set-NetIPInterface -DHCP Enabled
    $interface | Set-DnsClientServerAddress -ResetServerAddresses
}
else {
    echo ""
    echo "No action"
}

Start-Sleep 5
cmd /k ipconfig