# 8.1.ps1 - Перенос узлов в другую подсеть

$SourceSwitchName = "10.9.12.0/24"
$TargetSubnet = "10.9.10.0" 
$TargetSwitchName = "$TargetSubnet/24"
$ExportPath = "C:\MigrationExport"

# Создание директории для экспорта
if (-not (Test-Path -Path $ExportPath)) {
    New-Item -ItemType Directory -Path $ExportPath
}

# Получение и экспорт ВМ из исходной подсети [cite: 65]
$VMsToMigrate = Get-VMNetworkAdapter -SwitchName $SourceSwitchName | Select-Object VMName -Unique

foreach ($VM in $VMsToMigrate) {
    Write-Host "Экспорт $($VM.VMName)..."
    Export-VM -Name $VM.VMName -Path $ExportPath
    # Удаление экспортированной ВМ [cite: 66]
    Write-Host "Удаление $($VM.VMName)..."
    Remove-VM -Name $VM.VMName -Force
}

# Создание нового виртуального коммутатора для переноса [cite: 67]
Write-Host "Создание нового коммутатора $TargetSwitchName..."
New-VMSwitch -Name $TargetSwitchName -SwitchType Private

# Импорт ВМ в новую подсеть [cite: 68]
$ExportedFolders = Get-ChildItem -Path $ExportPath -Directory

foreach ($Folder in $ExportedFolders) {
    $VMName = $Folder.Name
    $ConfigPath = Get-ChildItem -Path $Folder.FullName -Filter "*.vmcx" | Select-Object -First 1 -ExpandProperty "FullName"
    
    Write-Host "Импорт $VMName как copy-$VMName..."
    Import-VM -Path $ConfigPath -Copy -GenerateNewId -VhdDestinationPath "C:\VM"
    Rename-VM -Name $VMName -NewName "copy-$VMName"
    
    # Подключение к новому коммутатору
    Connect-VMNetworkAdapter -VMName "copy-$VMName" -SwitchName $TargetSwitchName
    Start-VM -Name "copy-$VMName"
}

[cite_start]Write-Host "Перенос ВМ завершен. Не забудьте настроить IP-адресацию в импортированных ВМ для новой подсети, чтобы проверить сетевую доступность." [cite: 71]
