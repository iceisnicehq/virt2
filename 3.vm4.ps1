# 3.4.ps1 - Настройка сети на VM4

# Настройка интерфейса для сети 10.9.19.0/24 со шлюзом на VM3
Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | New-NetIPAddress -IPAddress 10.9.19.4 -PrefixLength 24 -DefaultGateway 10.9.19.3
Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Restart-NetAdapter

# Отключение брандмауэра
Set-NetFirewallProfile -Profile Domain, Private, Public -Enabled False
