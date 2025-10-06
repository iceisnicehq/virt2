
# После установки ОС на всех машинах, подключите их к коммутаторам
# Write-Host "Подключение сетевых адаптеров к коммутаторам..."
Add-VMNetworkAdapter -VMName "VM1" -SwitchName $Switch1
Add-VMNetworkAdapter -VMName "VM2" -SwitchName $Switch1
Add-VMNetworkAdapter -VMName "VM5" -SwitchName $Switch1

Add-VMNetworkAdapter -VMName "VM1" -SwitchName $Switch2
Add-VMNetworkAdapter -VMName "VM3" -SwitchName $Switch2
Add-VMNetworkAdapter -VMName "VM4" -SwitchName $Switch2

# Подключение VM3 к внешней сети
$ExternalSwitch = Get-VMSwitch -SwitchType External
Add-VMNetworkAdapter -VMName "VM3" -SwitchName $ExternalSwitch.Name

