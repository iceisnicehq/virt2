# 8.1.ps1 - Перенос узлов в другую подсеть

$SourceSwitchName = "10.9.12.0/24"
$TargetSubnet = "10.9.10.0" 
$TargetSwitchName = "$TargetSubnet/24"
$ExportPath = "C:\MigrationExport"

New-VMSwitch -Name "10.9.10.0/24" -SwitchType Private

# и дальше всё как в 3.0.ps1
# Удаляем лишние адаптеры
# добавляем новый адаптер
# Настраиваем IP

