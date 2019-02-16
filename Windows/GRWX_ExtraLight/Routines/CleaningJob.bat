:: a PYL production
echo off
pushd "%~dp0"
cls
echo:

echo -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-_-__--_-__-

:: cleaning job
echo:
echo Nettoyage : etape 1 creation du profile de nettoyage
echo:
:: etape 1 creation du profile de nettoyage
echo Active Setup Temp Folders - NO
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Active Setup Temp Folders" /v "StateFlags0012" /t REG_DWORD /d 0 /f

echo Compress old files - NO
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Compress old files" /v "StateFlags0012" /t REG_DWORD /d 0 /f

echo Content Indexer Cleaner - YES
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Content Indexer Cleaner" /v "StateFlags0012" /t REG_DWORD /d 1 /f

echo Downloaded Program Files - NO
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Downloaded Program Files" /v "StateFlags0012" /t REG_DWORD /d 0 /f

echo GameNewsFiles - YES
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\GameNewsFiles" /v "StateFlags0012" /t REG_DWORD /d 2 /f

echo GameStatisticsFiles - NO
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\GameStatisticsFiles" /v "StateFlags0012" /t REG_DWORD /d 0 /f
 
echo GameUpdateFiles - NO
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\GameUpdateFiles" /v "StateFlags0012" /t REG_DWORD /d 0 /f

echo Internet Cache Files - YES
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Internet Cache Files" /v "StateFlags0012" /t REG_DWORD /d 2 /f

echo Memory Dump Files - YES
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Memory Dump Files" /v "StateFlags0012" /t REG_DWORD /d 2 /f

echo Offline Pages Files - YES
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Offline Pages Files" /v "StateFlags0012" /t REG_DWORD /d 2 /f

echo Old ChkDsk Files - YES
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Old ChkDsk Files" /v "StateFlags0012" /t REG_DWORD /d 2 /f

echo Previous Installations - YES
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Previous Installations" /v "StateFlags0012" /t REG_DWORD /d 0 /f

echo Recycle Bin - NO
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Recycle Bin" /v "StateFlags0012" /t REG_DWORD /d 0 /f

echo Service Pack Cleanup - YES
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Service Pack Cleanup" /v "StateFlags0012" /t REG_DWORD /d 2 /f

echo Setup Log Files - YES
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Setup Log Files" /v "StateFlags0012" /t REG_DWORD /d 2 /f

echo System error memory dump files - YES
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error memory dump files" /v "StateFlags0012" /t REG_DWORD /d 2 /f

echo System error minidump files - YES
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error minidump files" /v "StateFlags0012" /t REG_DWORD /d 2 /f

echo Temporary Files - YES
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Files" /v "StateFlags0012" /t REG_DWORD /d 2 /f

echo Temporary Setup Files - NO
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Setup Files" /v "StateFlags0012" /t REG_DWORD /d 0 /f

echo Thumbnail Cache - YES
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Thumbnail Cache" /v "StateFlags0012" /t REG_DWORD /d 2 /f

echo Update Cleanup - NO
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Update Cleanup" /v "StateFlags0012" /t REG_DWORD /d 0 /f

echo Upgrade Discarded Files - NO
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Upgrade Discarded Files" /v "StateFlags0012" /t REG_DWORD /d 0 /f

echo Windows Error Reporting Archive Files - YES
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting Archive Files" /v "StateFlags0012" /t REG_DWORD /d 2 /f

echo Windows Error Reporting Queue Files - YES
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting Queue Files" /v "StateFlags0012" /t REG_DWORD /d 2 /f

echo Windows Error Reporting System Archive Files - YES
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting System Archive Files" /v "StateFlags0012" /t REG_DWORD /d 2 /f

echo Windows Error Reporting System Queue Files - NO
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting System Queue Files" /v "StateFlags0012" /t REG_DWORD /d 0 /f

echo Windows Upgrade Log Files - YES
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Upgrade Log Files" /v "StateFlags0012" /t REG_DWORD /d 2 /f

echo:

:: etape 2 : nettoyage
echo:
echo Nettoyage - etape 2 - nettoyage
echo:

echo:
echo Si ccleaner est installe - cleaning par defaut et se fermer
echo:

if EXIST "%programfiles%\CCleaner\CCleaner64.exe" (
	"%programfiles%\CCleaner\CCleaner64.exe" /AUTO
) else if EXIST "%programfiles%\CCleaner\CCleaner.exe" (
	"%programfiles%\CCleaner\CCleaner.exe" /AUTO
)
echo:
echo:
echo:

start /b /wait CLEANMGR /sagerun:12 






exit