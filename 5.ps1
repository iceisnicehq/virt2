# 5.1.ps1 - Экспорт, удаление и импорт ВМ

$VMName = "VM5"
$ExportPath = "C:\ExportedVMs"

# Создаем директорию для экспорта, если она не существует
if (-not (Test-Path -Path $ExportPath)) {
    New-Item -ItemType Directory -Path $ExportPath
}

# Экспорт ВМ в указанную директорию [cite: 39, 40]
Write-Host "Экспорт $VMName в $ExportPath..."
Export-VM -Name $VMName -Path $ExportPath

# Удаление ВМ [cite: 41]
Write-Host "Удаление $VMName..."
Remove-VM -Name $VMName -Force

# Импорт ВМ с новым именем и префиксом "copy" [cite: 42, 43]
Write-Host "Импорт ВМ как copy-$VMName..."
$VMPath = Join-Path -Path $ExportPath -ChildPath $VMName
$ConfigPath = Get-ChildItem -Path $VMPath -Filter "*.vmcx" | Select-Object -First 1 -ExpandProperty "FullName"
Import-VM -Path $ConfigPath -Copy -GenerateNewId -VhdDestinationPath "C:\VM"
Rename-VM -Name $VMName -NewName "copy-$VMName"
