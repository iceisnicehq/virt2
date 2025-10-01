# 7.1.ps1 - Работа с виртуальными дисками

$VHDName = "TVVP-XX-YY.vhdx"
$VHDPath = "C:\VM\$VHDName"
$VHDSize = 20GB
$VMTarget1 = "VM4"
$VMTarget2 = "VM1"
$User = "Administrator"
$Password = "P@ssw0rd" | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential($User, $Password)

# Создание виртуального диска (VHDX) [cite: 60]
Write-Host "Создание виртуального диска $VHDName..."
New-VHD -Path $VHDPath -SizeBytes $VHDSize

# Подключение диска к VM4 [cite: 61]
Write-Host "Подключение диска к $VMTarget1..."
Add-VMHardDiskDrive -VMName $VMTarget1 -Path $VHDPath

# Проверка, что диск виден в гостевой ОС VM4 [cite: 62]
Write-Host "Проверка диска в $VMTarget1..."
Invoke-Command -VMName $VMTarget1 -Credential $Credential -ScriptBlock {
    # Онлайн, инициализация, форматирование диска
    Get-Disk | Where-Object { $_.OperationalStatus -eq 'Offline' } | Set-Disk -IsOffline $false
    Get-Disk | Where-Object { $_.PartitionStyle -eq 'RAW' } | Initialize-Disk -PartitionStyle GPT -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -Confirm:$false
    Get-Disk | Select-Object Number, FriendlyName, Size
}

# Отключение диска от VM4 и перенос на VM1 [cite: 63]
Write-Host "Отключение диска от $VMTarget1..."
Remove-VMHardDiskDrive -VMName $VMTarget1 -Path $VHDPath

Write-Host "Подключение диска к $VMTarget2..."
Add-VMHardDiskDrive -VMName $VMTarget2 -Path $VHDPath

# Проверка, что диск виден в гостевой ОС VM1 [cite: 64]
Write-Host "Проверка диска в $VMTarget2..."
Invoke-Command -VMName $VMTarget2 -Credential $Credential -ScriptBlock {
    # Диск уже отформатирован, нужно только сделать его онлайн
    Get-Disk | Where-Object { $_.OperationalStatus -eq 'Offline' } | Set-Disk -IsOffline $false
    Get-Disk | Select-Object Number, FriendlyName, Size
}
