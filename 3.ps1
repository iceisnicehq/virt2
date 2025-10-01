# 3.1.ps1 - Настройка сети на VM1

# Настройка первого интерфейса для сети 10.9.12.0/24
Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Select-Object -First 1 | New-NetIPAddress -IPAddress 10.9.12.1 -PrefixLength 24
Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Select-Object -First 1 | Restart-NetAdapter

# Настройка второго интерфейса для сети 10.9.19.0/24
Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Select-Object -Last 1 | New-NetIPAddress -IPAddress 10.9.19.1 -PrefixLength 24
Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Select-Object -Last 1 | Restart-NetAdapter

# Отключение брандмауэра
Set-NetFirewallProfile -Profile Domain, Private, Public -Enabled False
