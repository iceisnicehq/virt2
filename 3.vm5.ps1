# --- Interface Configuration (connects to 10.9.12.0/24) ---
New-NetIPAddress -InterfaceAlias "Ethernet 2" -IPAddress 10.9.12.5 -PrefixLength 24 -DefaultGateway 10.9.12.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet 2" -ServerAddresses "94.232.137.104", "94.232.137.105"

# --- Restart Adapter ---
Restart-NetAdapter -InterfaceAlias "Ethernet 2"

# --- Disable Firewall ---
Set-NetFirewallProfile -Profile Domain, Private, Public -Enabled False

