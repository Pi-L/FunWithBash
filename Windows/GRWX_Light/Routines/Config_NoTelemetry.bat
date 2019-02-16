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
echo Ne pas envoyer de donnees complementaires a microsoft apres un crash
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /f /v "DontSendAdditionalData" /t REG_DWORD /d 1
:: pas trop necessaire vu que la GP au dessus superseed le current user mais bon... overkill qd tu nous tiens
REG ADD "HKCU\Software\Microsoft\Windows\Windows Error Reporting" /f /v "DontSendAdditionalData" /t REG_DWORD /d 1

echo:
echo ne pas autoriser la telemetry
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f

echo:
echo Disable Error Reporting
REG ADD "HKLM\SOFTWARE\Microsoft\PCHealth\ErrorReporting" /v "DoReport" /t REG_DWORD /d 0 /f

echo:
echo Disable NetCrawling
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "NoNetCrawling" /t REG_DWORD /d 00000001 /f

echo:
echo ne pas autoriser infection report
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontReportInfectionInformation" /t REG_DWORD /d 1 /f

echo Disable SpyNet
REG ADD "HKLM\SOFTWARE\Microsoft\Microsoft Antimalware\SpyNet" /v "SpyNetReporting" /t REG_DWORD /d 00000000 /f

echo:
echo Passe valeur TelemetryConsent a 0 pour EMET
REG ADD "HKCU\Software\Microsoft\EMET" /v "TelemetryConsent" /t REG_DWORD /d 0 /f

echo:
echo Passe "Value" de la clef Telemetry a 0 pour Visual studio 14
REG ADD "HKCU\Software\Microsoft\VisualStudio\14.0_Config\FeatureFlags\Solution\Telemetry" /v "Value" /t REG_DWORD /d 0 /f
REG ADD "HKEY_USERS\S-1-5-21-839663642-2540883381-1800796543-1000\Software\Microsoft\VisualStudio\14.0_Config\FeatureFlags\Solution\Telemetry" /v "Value" /t REG_DWORD /d 0 /f



:: disable perftrack
echo:
echo Desactiver PerfTrack
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WDI\{9c5a40da-b965-4fc3-8781-88dd50a6299d}" /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WDI\{9c5a40da-b965-4fc3-8781-88dd50a6299d}" /v "ScenarioExecutionEnabled" /t REG_DWORD /d 00000000 /f


REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Diagnostics\Performance" /v "DisableDiagnosticTracing" /t REG_DWORD /d 00000001 /f

:: not sur about this one 
echo:
echo Scripted Diagnostics Provider - disable Query Remote Server - might be useful

REG ADD "HKCU\Software\Microsoft\Windows\ScriptedDiagnosticsProvider\Policy" /v "EnableQueryRemoteServer" /t REG_DWORD /d 00000000 /f

:: Disable some telemetry scheduled tasks
echo:
echo:
echo -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-_-__--_-__-
echo TELEMETRY
echo:
echo Disable some telemetry scheduled tasks
echo:
echo:
echo Disable Application Experience\AitAgent
schtasks /change /tn "\Microsoft\Windows\Application Experience\AitAgent" /disable

echo:
echo Disable Application Experience\ProgramDataUpdater
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable

echo:
echo Disable Customer Experience Improvement Program\Consolidator
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable

echo:
echo Disable Customer Experience Improvement Program\KernelCeipTask
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable

echo:
echo Disable Customer Experience Improvement Program\UsbCeip
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable

echo:
echo Disable Autochk\Proxy
schtasks /change /tn "\Microsoft\Windows\Autochk\Proxy" /disable

echo:
echo Disable DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /disable

echo:
echo Disable Maintenance\WinSAT
schtasks /change /tn "\Microsoft\Windows\Maintenance\WinSAT" /disable

echo:
echo:
echo delete some telemetry scheduled tasks
echo:

echo DELETE Application Experience\AitAgent
schtasks /Delete /tn "\Microsoft\Windows\Application Experience\AitAgent" /F

echo:
echo DELETE Application Experience\ProgramDataUpdater
schtasks /Delete /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /F

echo:
echo DELETE Customer Experience Improvement Program\Consolidator
schtasks /Delete /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /F

echo:
echo DELETE Customer Experience Improvement Program\KernelCeipTask
schtasks /Delete /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /F

echo:
echo DELETE Customer Experience Improvement Program\UsbCeip
schtasks /Delete /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /F

echo:
echo DELETE Autochk\Proxy
schtasks /Delete /tn "\Microsoft\Windows\Autochk\Proxy" /F

echo:
echo DELETE DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector
schtasks /Delete /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /F

echo no name dans office

REG ADD "HKEY_USERS\%SID%\Software\Microsoft\Office\Common\UserInfo" /v "UserName" /t REG_SZ /d "" /f
REG ADD "HKEY_USERS\%SID%\Software\Microsoft\Office\Common\UserInfo" /v "UserInitials" /t REG_SZ /d "" /f
REG ADD "HKEY_USERS\%SID%\Software\Microsoft\Office\Common\UserInfo" /v "Company" /t REG_SZ /d "" /f

echo:
:: Delete some telemetry services et vide l'autologger
echo:
echo Stop and Delete some telemetry Services
echo DiagTrack
sc stop DiagTrack
sc delete DiagTrack
echo dmwappushservice
sc stop dmwappushservice 
sc delete dmwappushservice

echo:
echo Telemetry - Prendre controle de %PROGRAMDATA%\Microsoft\Diagnosis\ETLLogs\AutoLogger
echo supprimer puis refuser les permissions d'acces du system sur ce dossier
echo:
if EXIST "%PROGRAMDATA%\Microsoft\Diagnosis\ETLLogs\AutoLogger" (
	takeown /f "%PROGRAMDATA%\Microsoft\Diagnosis\ETLLogs\AutoLogger" /r /d o

	icacls "%PROGRAMDATA%\Microsoft\Diagnosis\ETLLogs\AutoLogger" /grant administrators:F /t
	icacls "%PROGRAMDATA%\Microsoft\Diagnosis\ETLLogs\AutoLogger" /remove:g system /t /c
	icacls "%PROGRAMDATA%\Microsoft\Diagnosis\ETLLogs\AutoLogger" /deny system:FMRXRW /t /c

	echo vider et ecrire nope dans AutoLogger-Diagtrack-Listener.etl
	echo nope > %PROGRAMDATA%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl


	echo:
	echo:
	REM if %ERRORLEVEL% NEQ 0 ( 
		REM echo l'ecriture dans utoLogger-Diagtrack-Listener.etl n'ayant pas fonctionne, planification auto d'un chkdsk /f du disk systeme
		REM REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "BootExecute" /t REG_MULTI_SZ /d "Autocheck autochk /p \??\%homedrive%" /f 
	REM ) else ( echo ecriture reussie )
)
echo:
REM echo destroy System Volume Information but does it and is it effective... who knows

REM if EXIST "%HOMEDRIVE%\System Volume Information" (
	
	REM takeown /f "%HOMEDRIVE%\System Volume Information" /r /d o
	REM icacls "%HOMEDRIVE%\System Volume Information" /grant administrators:F /t
	REM del /s /q "%HOMEDRIVE%\System Volume Information\*.*"
	REM rd /s /q "%HOMEDRIVE%\System Volume Information"
	REM rd /s /q "%HOMEDRIVE%\System Volume Information\SPP"
	REM rd /s /q "%HOMEDRIVE%\System Volume Information\Windows Backup"
	REM rd /s /q "%HOMEDRIVE%\System Volume Information\WindowsImageBackup"
REM )


echo:
echo diverses application non-windows
REG ADD "HKCU\Software\Vivaldi\StabilityMetrics" /v "user_experience_metrics.stability.exited_cleanly" /t REG_DWORD /d 0 /f
REG ADD "HKEY_USERS\%SID%\Software\Vivaldi\StabilityMetrics" /v "user_experience_metrics.stability.exited_cleanly" /t REG_DWORD /d 0 /f




exit