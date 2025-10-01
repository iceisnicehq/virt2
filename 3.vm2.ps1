# 3.2.ps1 - Настройка сети на VM2

# Настройка интерфейса для сети 10.9.12.0/24 (шлюз указан на VM3)
Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | New-NetIPAddress -IPAddress 10.9.12.2 -PrefixLength 24 -DefaultGateway 10.9.12.3
Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Restart-NetAdapter

# Отключение брандмауэра
Set-NetFirewallProfile -Profile Domain, Private, Public -Enabled False
