:: a PYL production
:: ca marche pas. pb d argument
echo off
setlocal EnableDelayedExpansion
pushd "%~dp0"
cls
echo:
set bypassask=0
Set Choix=Aucun
Set param1=%1

if [!param1!] NEQ [] ( 
	if !param1! == d ( 
		set Choix=D 
		set bypassask=1
	)
	if !param1! == e ( 
		set Choix=e 
		set bypassask=1
	)
)

if NOT !bypassask! == 1 (
	Set /p statutWU="E to Enable [manuel], D to Disable WinUpdate [e/d] : "

	if !statutWU! == e (Set Choix=e)
	if !statutWU! == E (Set Choix=e)
	if !statutWU! == d (Set Choix=D)
	if !statutWU! == D (Set Choix=D)
)



if !Choix! == e (

	echo:
	echo Logged-on user can decide whether to restart the client computer.
	REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoRebootWithLoggedOnUsers" /t REG_DWORD /d 00000001 /f

	echo:
	echo UI - Passe les mises a jour en manuel
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 2 /f

	echo:
::	echo Manually download policies - forced
::	REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 00000002 /f
	echo Delete AUOptions
	REG Delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /f

	echo:
	echo Enable Automatic Updates
	REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 00000000 /f

	echo:
	echo Enable RebootRelaunchTimeout
	REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "RebootRelaunchTimeoutEnabled" /t REG_DWORD /d 1 /f

	echo:
	echo Time between prompts for a scheduled restart. 440 min.
	REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "RebootRelaunchTimeout" /t REG_DWORD /d 440 /f

	sc config "TrustedInstaller"  start= demand
	net start TrustedInstaller

	sc config "BITS"  start= demand
	net start BITS

	sc config "wuauserv" start= demand
	net start wuauserv





	"%windir%"\system32\wuauclt.exe /a /DetectNow
	"%windir%"\system32\wuauclt.exe /r
rem	"%windir%"\system32\wuapp.exe

)



if %Choix% == D (

	echo:
	echo UI - Desactive les mises a jour
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 1 /f

	echo Delete AUOptions
	REG Delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /f

	echo:
	echo Delete schedule installation : Every day
	REG Delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "ScheduledInstallDay" /f

	echo:
	echo Delete schedule installation : a 21h
	REG Delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "ScheduledInstallTime" /f

	echo:
	echo  DoN'T Silently install minor updates.
	REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AutoInstallMinorUpdates" /t REG_DWORD /d 00000000 /f

	echo:
	echo Disable Automatic Updates
	REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 00000001 /f

	echo:
	echo The WSUS server does not distribute available signed non-Microsoft updates.
	REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "AcceptTrustedPublisherCerts" /t REG_DWORD /d 00000000 /f

	sc config "wuauserv" start= disabled
	net stop wuauserv

	sc config "TrustedInstaller"  start= disabled
	net stop TrustedInstaller

	sc config "BITS"  start= disabled
	net stop BITS

)

if %Choix% == Aucun (
	echo aucun choix
	pause
)



exit