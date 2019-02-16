:: a PYL production
echo off
pushd "%~dp0"
cls
echo:

set "SID="
for /f "delims= " %%a in ('"wmic useraccount where name='%UserName%' get sid"') do (
   if not "%%a"=="SID" (          
      set SID=%%a
	  goto prison   
   )   
)
:prison
echo:
echo SID Utilisateur : %SID%
echo:

echo stop bonjour service
echo:
net stop "Bonjour Service"
sc config "Bonjour Service" start= disabled


IF EXIST "%ProgramFiles%\Logitech\SetPointP\LogiSmoothFirefoxExt" (

	RD /s /q "%ProgramFiles%\Logitech\SetPointP\XLogiSmoothFirefoxExt" 
	ren "%ProgramFiles%\Logitech\SetPointP\LogiSmoothFirefoxExt" XLogiSmoothFirefoxExt

)

schtasks /change /tn "Opera scheduled Autoupdate 1392446635" /disable

schtasks /change /tn "Adobe Flash Player Updater" /disable

schtasks /change /tn "AdobeAAMUpdater-1.0-adumbrate-orko@2501" /disable

REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v uTorrent /f

REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v Steam /f
REG ADD "HKCU\Software\Valve\Steam" /v SuppressAutoRun /t REG_DWORD /d 1 /f
REG ADD "HKEY_USERS\%SID%\Software\Valve\Steam" /v SuppressAutoRun /t REG_DWORD /d 1 /f
net stop "Steam Client Service"
sc config "Steam Client Service" start= DEMAND

REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v SunJavaUpdateSched /f





exit