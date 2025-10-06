# 5.1.ps1 - Экспорт, удаление и импорт ВМ

$VMName = "VM5"
$ExportPath = "C:\Export"

Export-VM -Name $VMName -Path $ExportPath
Remove-VM -Name $VMName -Force

$VMPath = Join-Path -Path $ExportPath -ChildPath $VMName
$ConfigPath = Get-ChildItem -Path $VMPath -Filter "*.vmcx" | Select-Object -First 1 -ExpandProperty "FullName"

Import-VM -Path $ConfigPath -Copy -GenerateNewId -VhdDestinationPath "C:\VM"
Rename-VM -Name $VMName -NewName "copy-$VMName"
