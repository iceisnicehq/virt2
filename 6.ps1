# 6.1.ps1 - Работа с контрольными точками на VM3

$VMName = "VM3"
$CheckpointName1 = "before_update"
$CheckpointName2 = "after_update"
$FilePath = "C:\LabFile.txt"
$User = "Administrator"
$Password = "P@ssw0rd" | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential($User, $Password)

# Создание первой контрольной точки "before_update" [cite: 45]
Write-Host "Создание контрольной точки '$CheckpointName1' для $VMName..."
Checkpoint-VM -Name $VMName -SnapshotName $CheckpointName1

# Загрузка пользовательских данных (создание файла) на VM3 [cite: 49]
Write-Host "Создание файла $FilePath на $VMName..."
Invoke-Command -VMName $VMName -Credential $Credential -ScriptBlock {
    New-Item -Path $using:FilePath -ItemType File -Value "User Data"
}

# Создание второй контрольной точки "after_update" [cite: 50]
Write-Host "Создание контрольной точки '$CheckpointName2' для $VMName..."
Checkpoint-VM -Name $VMName -SnapshotName $CheckpointName2

# Применение первой контрольной точки и проверка отсутствия файла [cite: 51, 52]
Write-Host "Применение '$CheckpointName1' и проверка отсутствия файла..."
Restore-VMCheckpoint -Name $VMName -SnapshotName $CheckpointName1 -Confirm:$false
Start-VM -Name $VMName
$FileExistsBefore = Invoke-Command -VMName $VMName -Credential $Credential -ScriptBlock { Test-Path -Path $using:FilePath }
Write-Host "Файл существует после отката к 'before_update': $FileExistsBefore" # Должно быть False

# Применение второй контрольной точки и проверка наличия файла [cite: 55, 57]
Write-Host "Применение '$CheckpointName2' и проверка наличия файла..."
Restore-VMCheckpoint -Name $VMName -SnapshotName $CheckpointName2 -Confirm:$false
Start-VM -Name $VMName
$FileExistsAfter = Invoke-Command -VMName $VMName -Credential $Credential -ScriptBlock { Test-Path -Path $using:FilePath }
Write-Host "Файл существует после отката к 'after_update': $FileExistsAfter" # Должно быть True
