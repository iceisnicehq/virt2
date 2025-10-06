# 4.1.ps1 - Настройка NAT на VM3

# Установка роли маршрутизации
Install-WindowsFeature -Name Routing -IncludeManagementTools
Install-WindowsFeature -Name RemoteAccess -IncludeManagementTools
Install-WindowsFeature -Name RSAT-RemoteAccess-PowerShell

Restart-Computer -Force

# Создание нового NAT-объекта для внутренней сети
Import-Module NetNat

New-NetNat -Name "NATNet" -InternalIPInterfaceAddressPrefix "10.9.19.0/24"
