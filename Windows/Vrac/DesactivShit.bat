echo off
pushd "%~dp0"
cls
echo stop bonjour service
echo:
net stop "Bonjour Service"
sc config "Bonjour Service" start= disabled

sc config "TrustedInstaller"  start= disabled
net stop TrustedInstaller

sc config "BITS"  start= disabled
net stop BITS

echo:
:: echo Delete 
:: REG Delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "ScheduledInstallDay" /f

echo:
:: echo Delete 
:: REG Delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "ScheduledInstallTime" /f

echo:
:: echo Delete 
:: REG Delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "ScheduledInstallDay" /f

echo:
echo Delete Epson
REG Delete HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "EPSON Stylus DX7400 Series" /f

echo:
echo delete varc de clef

REG DELETE "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" /v "SunJavaUpdateSched" /f
REG DELETE "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" /v "Command Center" /f
REG DELETE "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" /v "KeePass 2 PreLoad" /f
REG DELETE "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" /v "Live Update" /f

REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run32" /v "5KPlayer.exe" /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run32" /v "Command Center" /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run32" /v "Eraser" /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run32" /v "KeePass 2 PreLoad" /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run32" /v "Live Update" /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run32" /v "SunJavaUpdateSched" /f

REG DELETE "HKLM\SOFTWARE\Wow6432Node\Microsoft\Shared Tools\MSConfig\startupreg\SunJavaUpdateSched" /f




IF EXIST "%ProgramFiles%\Logitech\SetPointP\LogiSmoothFirefoxExt" (

RD /s /q "%ProgramFiles%\Logitech\SetPointP\XLogiSmoothFirefoxExt" 
ren "%ProgramFiles%\Logitech\SetPointP\LogiSmoothFirefoxExt" XLogiSmoothFirefoxExt

)

::schtasks /change /tn "Opera scheduled Autoupdate 1392446635" /disable
schtasks /change /tn "Adobe Flash Player Updater" /disable
schtasks /change /tn "AdobeAAMUpdater-1.0-adumbrate-john" /disable
schtasks /change /tn "Adobe Acrobat Update Task" /disable

IF EXIST "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\Kaspersky Software Updater Beta.lnk" (
	echo supprime KSU au demmarrage
	echo:
	del "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\Kaspersky Software Updater Beta.lnk" 
	echo:
)

IF EXIST "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\Killer Network Manager.lnk" (
	echo supprime KNM au demmarrage
	echo:
	del "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\StartUp\Killer Network Manager.lnk" 
	echo:
)

IF EXIST "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Kaspersky Software Updater Beta.lnk" (
	echo supprime KSU au demmarrage
	echo:
	del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Kaspersky Software Updater Beta.lnk" 
	echo:
)

IF EXIST "%APPDATA%\Microsoft\Windows\Start Menu\Programs\StartUp\Killer Network Manager.lnk" (
	echo supprime KNM au demmarrage
	echo:
	del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\StartUp\Killer Network Manager.lnk" 
	echo:
)
