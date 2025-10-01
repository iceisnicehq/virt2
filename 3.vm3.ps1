# 3.3.ps1 - Настройка сети на VM3 (NAT)

# Настройка внутреннего интерфейса для сети 10.9.19.0/24
# (Предполагается, что внутренний интерфейс не имеет настроенного IP)
Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | ForEach-Object {
    if ((Get-NetIPConfiguration -InterfaceIndex $_.ifIndex).IPv4Address.IPAddress -notlike "169.254.*") {
        # Пропускаем, если это внешний адаптер с IP
    } else {
        # Настраиваем внутренний адаптер
        New-NetIPAddress -InterfaceIndex $_.ifIndex -IPAddress 10.9.19.3 -PrefixLength 24
        Restart-NetAdapter -InterfaceIndex $_.ifIndex
    }
}

# Включение IP-форвардинга
Set-NetIPInterface -Forwarding Enabled

# Отключение брандмауэра
Set-NetFirewallProfile -Profile Domain, Private, Public -Enabled False
