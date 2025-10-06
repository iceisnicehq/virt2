# --- Interface Configuration (connects to 10.9.19.0/24) ---
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 10.9.19.4 -PrefixLength 24 -DefaultGateway 10.9.19.3
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses "94.232.137.104", "94.232.137.105"

# --- Add Static Route to reach the other internal subnet via VM1 ---
New-NetRoute -InterfaceAlias "Ethernet" -DestinationPrefix "10.9.12.0/24" -NextHop 10.9.19.1

# --- Restart Adapter ---
Restart-NetAdapter -InterfaceAlias "Ethernet"

# --- Disable Firewall ---
Set-NetFirewallProfile -Profile Domain, Private, Public -Enabled False

