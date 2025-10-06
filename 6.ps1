# 6.1.ps1 - Работа с контрольными точками на VM3

$VMName = "VM4"
$CheckpointName1 = "before_update"
$CheckpointName2 = "after_update"

Checkpoint-VM -Name $VMName -SnapshotName $CheckpointName1

# Cоздание файла для проверки

Checkpoint-VM -Name $VMName -SnapshotName $CheckpointName2

Restore-VMCheckpoint -Name $VMName -Name $CheckpointName1 -Confirm:$false
Start-VM -Name $VMName

Restore-VMCheckpoint -Name $VMName -Name $CheckpointName2 -Confirm:$false
Start-VM -Name $VMName
