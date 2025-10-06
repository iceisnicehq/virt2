# 6.1.ps1 - Работа с контрольными точками на VM3
Checkpoint-VM -Name "VM4" -SnapshotName "before_update"

# Cоздание файла для проверки..... руками

Checkpoint-VM -Name "VM4" -SnapshotName "after_update"

Restore-VMCheckpoint -Name "VM4" -Name "before_update" -Confirm:$false
Start-VM -Name "VM4"

Restore-VMCheckpoint -Name "VM4" -Name "after_update" -Confirm:$false
Start-VM -Name "VM4"
