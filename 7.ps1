# Создание виртуального диска (VHDX) [cite: 60]
New-VHD -Path "C:\VM\TVVP-22-03.vhdx" -SizeBytes 20GB
Add-VMHardDiskDrive -VMName "VM4" -Path "C:\VM\TVVP-22-03.vhdx"

Remove-VMHardDiskDrive -VMName "VM4" -Path "C:\VM\TVVP-22-03.vhdx"
Add-VMHardDiskDrive -VMName "VM1" -Path "C:\VM\TVVP-22-03.vhdx"

