# 4.1.ps1 - Настройка NAT на VM3

# Установка роли маршрутизации
Install-WindowsFeature -Name Routing -IncludeManagementTools

# Создание нового NAT-объекта для внутренней сети
Install-NetNat -Name "NATNetwork" -InternalIPInterfaceAddressPrefix "10.9.19.0/24"
