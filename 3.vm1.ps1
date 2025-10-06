# --- Configuration for the first interface (connects to 10.9.19.0/24) ---
New-NetIPAddress -InterfaceAlias "Ethernet 3" -IPAddress 10.9.19.1 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceAlias "Ethernet 3" -ServerAddresses "94.232.137.104", "94.232.137.105"
Restart-NetAdapter -InterfaceAlias "Ethernet 3"

# --- Configuration for the second interface (connects to 10.9.12.0/24) ---
New-NetIPAddress -InterfaceAlias "Ethernet 2" -IPAddress 10.9.12.1 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceAlias "Ethernet 2" -ServerAddresses "94.232.137.104", "94.232.137.105"
Restart-NetAdapter -InterfaceAlias "Ethernet 2"

# --- Add Default Gateway to reach the internet via VM3 (NAT Router) ---
# This tells VM1 to send all external traffic to VM3
New-NetRoute -DestinationPrefix 0.0.0.0/0 -NextHop 10.9.19.3

# --- Enable IP Forwarding to allow routing between the two subnets ---
Set-NetIPInterface -InterfaceAlias "Ethernet 2" -Forwarding Enabled
Set-NetIPInterface -InterfaceAlias "Ethernet 3" -Forwarding Enabled

# --- Disable Firewall ---
Set-NetFirewallProfile -Profile Domain, Private, Public -Enabled False

