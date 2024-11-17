@echo off
chcp 65001 > nul
cls

:: Renk Modu: Yeşil
color 2

:: Menü Başlığı
echo =============================================================================== 
echo ==============  ***  SİSTEM YÖNETİM ARACI  ***  =================
echo =============================================================================== 
echo                         Tasarlayan: F3NR1R
echo =============================================================================== 
echo.

:MENU
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

:: Seçim bölümü
set /p choice=Bir seçenek girin (1-22): 

:: Koşul bölümü
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
if "%choice%"=="22" exit
goto MENU

:: İşlem bölümü
:COMPUTER_INFO
cls
echo Bilgisayar Seri Numarası:
wmic bios get serialnumber
echo.
echo Bilgisayar Adı:
hostname
echo.
echo Marka ve Model:
wmic computersystem get manufacturer, model
pause
goto MENU

:CPUINFO
cls
echo CPU Bilgileri:
wmic cpu get caption, deviceid, name, numberofcores, maxclockspeed
pause
goto MENU

:STORAGE
cls
echo Depolama Alanı Durumu:
wmic logicaldisk get caption, description, freespace, size
pause
goto MENU

:DISK
cls
echo Disk Durumu:
wmic logicaldisk get caption, description, freespace, size
pause
goto MENU

:CLEANUP
cls
echo Disk Temizliği başlatılıyor...
cleanmgr
pause
goto MENU

:CLEAN_TEMP_FILES
cls
echo Geçici dosyalar temizleniyor...
del /q /f /s %TEMP%\*
pause
goto MENU

:ENABLE_FIREWALL
cls
echo Güvenlik Duvarı etkinleştiriliyor...
netsh advfirewall set allprofiles state on
pause
goto MENU

:DISABLE_FIREWALL
cls
echo Güvenlik Duvarı devre dışı bırakılıyor...
netsh advfirewall set allprofiles state off
pause
goto MENU

:GPUPDATE
cls
echo Grup Politikaları Güncelleniyor...
gpupdate /force
pause
goto MENU

:IP
cls
echo Bilgisayarın IP Adresi:
ipconfig | findstr /i "IPv4"
pause
goto MENU

:USERS
cls
echo Kullanıcı Hesapları:
net user
pause
goto MENU

:MEMORY
cls
echo RAM Bilgileri:
wmic memorychip get capacity, speed, manufacturer
pause
goto MENU

:OPTIMIZE_RAM
cls
echo RAM optimizasyonu yapılıyor...
taskkill /f /im explorer.exe > nul
start explorer.exe
pause
goto MENU

:CHKDSK
cls
echo Sabit diski tarıyor...
chkdsk C: /f /r /x
pause
goto MENU

:SYSINFO
cls
echo Sistem Bilgileri:
systeminfo
pause
goto MENU

:WINDOWSUPDATE
cls
echo Windows Güncelleme Durumu:
wmic qfe list brief /format:table
pause
goto MENU

:LICENSE
cls
echo Windows Lisans Durumu:
slmgr /xpr
pause
goto MENU

:WINVER
cls
echo Windows Sürüm Bilgisi:
winver
pause
goto MENU

:LAST_FORMAT_DATE
cls
echo Son Format Tarihi:
wmic os get installdate
pause
goto MENU

:CLEAR_DNS
cls
echo DNS Önbelleği temizleniyor...
ipconfig /flushdns
pause
goto MENU

:SFC
cls
echo Sistem dosyaları taranıyor...
sfc /scannow
pause
goto MENU

:: Bitiş.
