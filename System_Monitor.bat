@echo off
chcp 65001 > nul
cls
color 2

:: ============================
:: Yönetici Yetkisi Kontrolü
:: ============================
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Lütfen bu scripti YÖNETİCİ olarak çalıştırın!
    pause
    exit
)

:: ============================
:: Başlık ve Menü
:: ============================
:START
cls
echo =============================================================================== 
echo ==============  ***  SİSTEM YÖNETİM ARACI  ***  =================
echo =============================================================================== 
echo                         Tasarlayan: Dogukan ISPIRLI
echo =============================================================================== 
echo.
echo  1 -  Bilgisayar Seri Numarası ve Modelini Göster
echo  2 -  CPU Bilgilerini Göster
echo  3 -  Depolama Alanı Durumunu Göster
echo  4 -  Disk Durumunu Kontrol Et
echo  5 -  Disk Temizliği Başlat
echo  6 -  Geçici Dosyaları Temizle
echo  7 -  Güvenlik Duvarını Aç
echo  8 -  Güvenlik Duvarını Kapat
echo  9 -  Grup Politikalarını Güncelle
echo 10 -  IP Adresini Görüntüle
echo 11 -  Kullanıcı Hesaplarını Listele
echo 12 -  RAM Bilgilerini Göster
echo 13 -  RAM Optimizasyonu Yap
echo 14 -  Sabit Diski Tarama
echo 15 -  Sistem Bilgilerini Görüntüle
echo 16 -  Windows Güncelleme Durumunu Göster
echo 17 -  Windows Lisans Durumunu Göster
echo 18 -  Windows Sürüm Bilgisini Göster
echo 19 -  Son Format Tarihini Göster
echo 20 -  Ağ DNS Önbelleğini Temizle
echo 21 -  Windows Sistem Dosyalarını Onar
echo 22 -  Çıkış Yap
echo ===============================================================================

set /p choice=Bir seçenek girin (1-22): 

if "%choice%"=="1" goto COMPUTER_INFO
if "%choice%"=="2" goto CPUINFO
if "%choice%"=="3" goto STORAGE
if "%choice%"=="4" goto DISK
if "%choice%"=="5" goto CLEANUP
if "%choice%"=="6" goto CLEAN_TEMP_FILES
if "%choice%"=="7" goto ENABLE_FIREWALL
if "%choice%"=="8" goto DISABLE_FIREWALL
if "%choice%"=="9" goto GPUPDATE
if "%choice%"=="10" goto IP
if "%choice%"=="11" goto USERS
if "%choice%"=="12" goto MEMORY
if "%choice%"=="13" goto OPTIMIZE_RAM
if "%choice%"=="14" goto CHKDSK
if "%choice%"=="15" goto SYSINFO
if "%choice%"=="16" goto WINDOWSUPDATE
if "%choice%"=="17" goto LICENSE
if "%choice%"=="18" goto WINVER
if "%choice%"=="19" goto LAST_FORMAT_DATE
if "%choice%"=="20" goto CLEAR_DNS
if "%choice%"=="21" goto SFC
if "%choice%"=="22" goto EXIT
goto START

:: ============================
:: İşlem Bölümü
:: ============================

:COMPUTER_INFO
cls
echo Bilgisayar Seri Numarası:
powershell "Get-CimInstance Win32_BIOS | Select-Object -ExpandProperty SerialNumber"
echo.
echo Bilgisayar Adı:
hostname
echo.
echo Marka ve Model:
powershell "Get-CimInstance Win32_ComputerSystem | Select Manufacturer, Model"
pause
cls
goto START

:CPUINFO
cls
echo CPU Bilgileri:
powershell "Get-CimInstance Win32_Processor | Select Name, NumberOfCores, MaxClockSpeed"
pause
cls
goto START

:STORAGE
cls
echo Depolama Alanı Durumu:
powershell "Get-CimInstance Win32_LogicalDisk | Select DeviceID, MediaType, @{Name='FreeSpace(GB)';Expression={[math]::Round($_.FreeSpace/1GB,2)}}, @{Name='Size(GB)';Expression={[math]::Round($_.Size/1GB,2)}}"
pause
cls
goto START

:DISK
cls
echo Disk Durumu:
powershell "Get-PhysicalDisk | Select FriendlyName, MediaType, Size, HealthStatus"
pause
cls
goto START

:CLEANUP
cls
echo Disk Temizliği başlatılıyor...
cleanmgr
pause
cls
goto START

:CLEAN_TEMP_FILES
cls
echo Geçici dosyalar temizleniyor...
rd /s /q "%TEMP%" > nul 2>&1
md "%TEMP%"
echo Geçici dosyalar başarıyla temizlendi.
pause
cls
goto START

:ENABLE_FIREWALL
cls
echo Güvenlik Duvarı etkinleştiriliyor...
netsh advfirewall set allprofiles state on
pause
cls
goto START

:DISABLE_FIREWALL
cls
echo Güvenlik Duvarı devre dışı bırakılıyor...
netsh advfirewall set allprofiles state off
pause
cls
goto START

:GPUPDATE
cls
echo Grup Politikaları Güncelleniyor...
gpupdate /force
pause
cls
goto START

:IP
cls
echo IP Adresi Bilgisi:
ipconfig | findstr /i "IPv4"
pause
cls
goto START

:USERS
cls
echo Kullanıcı Hesapları:
net user
pause
cls
goto START

:MEMORY
cls
echo RAM Bilgileri:
powershell "Get-CimInstance Win32_PhysicalMemory | Select Manufacturer, Capacity, Speed"
pause
cls
goto START

:OPTIMIZE_RAM
cls
echo RAM optimizasyonu yapılıyor...
powershell "Clear-RecycleBin -Force; Start-Sleep -Seconds 1; [System.GC]::Collect(); Write-Host 'RAM optimizasyonu tamamlandı.'"
pause
cls
goto START

:CHKDSK
cls
echo Sabit disk taraması başlatılıyor...
chkdsk C: /f
pause
cls
goto START

:SYSINFO
cls
echo Sistem Bilgileri:
systeminfo
pause
cls
goto START

:WINDOWSUPDATE
cls
echo Windows Güncelleme Durumu:
powershell "Get-HotFix | Sort-Object InstalledOn -Descending | Select -First 10"
pause
cls
goto START

:LICENSE
cls
echo Windows Lisans Durumu:
slmgr /xpr
pause
cls
goto START

:WINVER
cls
echo Windows Sürüm Bilgisi:
systeminfo | findstr /i "OS Name"
systeminfo | findstr /i "OS Version"
pause
cls
goto START

:LAST_FORMAT_DATE
cls
echo Son Format (Kurulum) Tarihi:
powershell "(Get-CimInstance Win32_OperatingSystem).InstallDate"
pause
cls
goto START

:CLEAR_DNS
cls
echo DNS Önbelleği temizleniyor...
ipconfig /flushdns
echo DNS önbelleği başarıyla temizlendi.
pause
cls
goto START

:SFC
cls
echo Sistem dosyaları taranıyor...
sfc /scannow
pause
cls
goto START

:EXIT
cls
echo Çıkış yapılıyor... Görüşmek üzere!
timeout /t 2 > nul
exit
