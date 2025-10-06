# 2.1.ps1 - Создание виртуальных машин

# Имена ВМ для создания
$VMNames = @("VM1", "VM2", "VM3", "VM4", "VM5") 
$Memory = 4096MB # Объем ОЗУ
$VHDSize = 52GB # Размер виртуального диска
$PathToISO = "C:\VMs_ISO\WinServ2019.iso" # Путь к установочному образу ОС
$Gen = 2 # Поколение ВМ
$Switch1 = "10.9.12.0/24" # Имя первого коммутатора
$Switch2 = "10.9.19.0/24" # Имя второго коммутатора

# Создание виртуальных коммутаторов
New-VMSwitch -Name $Switch1 -SwitchType Private -Notes "Подсеть 1"
New-VMSwitch -Name $Switch2 -SwitchType Private -Notes "Подсеть 2"

# Цикл для создания каждой ВМ
foreach ($VMName in $VMNames) {
    $VHDPath = "C:\VM\$VMName.vhdx"
    
    # Создание ВМ
    Write-Host "Создание виртуальной машины: $VMName"
    New-VM -Name $VMName -MemoryStartupBytes $Memory -Generation $Gen -NewVHDPath $VHDPath -NewVHDSizeBytes $VHDSize
    
    # Настройка параметров ВМ
    Set-VM -Name $VMName -EnhancedSessionTransportType HVSocket
    Set-VMFirmware -VMName $VMName -EnableSecureBoot Off
    Set-VMProcessor -VMName $VMName -Count 4
    
    # Подключение ISO-образа
    Add-VMDvdDrive -VMName $VMName -Path $PathToISO
    
    # Запуск ВМ для установки ОС
    Start-VM -Name $VMName
    
    VMConnect.exe localhost $VMName # Раскомментируйте, чтобы открыть консоль
}

