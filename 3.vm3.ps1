# --- Configuration for the internal interface (connects to 10.9.19.0/24) ---
# We assume "Ethernet 2" is the external (DHCP) adapter and "Ethernet 3" is the internal one.
New-NetIPAddress -InterfaceAlias "Ethernet 2" -IPAddress 10.9.19.3 -PrefixLength 24
Restart-NetAdapter -InterfaceAlias "Ethernet 2"

# --- Enable IP Forwarding ---
Set-NetIPInterface -Forwarding Enabled

# --- Add Static Route to reach the other internal subnet via VM1 ---
New-NetRoute -InterfaceAlias "Ethernet 2" -DestinationPrefix "10.9.12.0/24" -NextHop 10.9.19.1

# --- Disable Firewall ---
Set-NetFirewallProfile -Profile Domain, Private, Public -Enabled False

