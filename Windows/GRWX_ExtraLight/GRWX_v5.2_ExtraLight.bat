:: a PYL production
pushd "%~dp0"
echo off
setlocal EnableDelayedExpansion
cls
echo:
echo -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-_-__--_-__-
echo:
echo                    The GOOD RIDDANCE Win10 BATCH
echo:
echo                A MultiPurpose Maintenance "programme"
echo:
echo -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-_-__--_-__-
:: penser … mettre le fichier HideGWXetc.vbs dans le meme dossier que ce batch
echo:
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
echo -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-_-__--_-__-

REM 
::
REM
::       it begins here
REM
::
REM 
	
echo:
echo demarre windows update and co
echo:

echo lancement de %~dp0Routines\ConfigUpdatesPolicies.bat
start "" /D "%~dp0Routines\" /wait /HIGH ConfigUpdatesPolicies.bat
start "" /D "%~dp0Routines\" /wait /HIGH StartWindowsUpdateServices.bat

echo:
echo -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-_-__--_-__-
echo:
echo:

echo:
echo Desinstallation de GWX - KB2952664 ...
wusa /uninstall /kb:2952664 /quiet /norestart
echo Desinstallation de GWX - KB3035583 ...
wusa /uninstall /kb:3035583 /quiet /norestart

:: not completly sure about this
echo:
echo Desinstallation de KB3012973
wusa /uninstall /kb:3012973 /norestart /quiet

echo Desinstallation de telemetry - KB2882822 ...
wusa /uninstall /kb:2882822 /quiet /norestart

echo Desinstallation de telemetry - KB3015249 ...
wusa /uninstall /kb:3015249 /quiet /norestart

echo Desinstallation de telemetry - KB3021917 ...
wusa /uninstall /kb:3021917 /quiet /norestart
echo Desinstallation de telemetry - KB3022345 ...
wusa /uninstall /kb:3022345 /quiet /norestart
echo Desinstallation de telemetry - KB3068708 ...
wusa /uninstall /kb:3068708 /quiet /norestart
echo Desinstallation de telemetry - KB3075249 ...
wusa /uninstall /kb:3075249 /quiet /norestart
echo Desinstallation de telemetry - KB3080149 ...
wusa /uninstall /kb:3080149 /quiet /norestart

echo Desinstallation de telemetry - KB3042058 ...
wusa /uninstall /kb:3042058 /quiet /norestart


:: Upgrading
:: Update that enables you to upgrade from Windows 7 to a later version of Windows
echo:
echo Desinstallation de KB2990214 - Enables upgrade from Windows 7 to a later version of Windows _donc a reactiver pr passer a 8.1_ ...
wusa /uninstall /kb:2990214 /quiet /norestart
echo Desinstallation de KB3112343 - passage de win 7 vers win 10
wusa /uninstall /kb:3112343 /quiet /norestart

echo Desinstallation de KB3081954 - passage de win 7 vers win 10
wusa /uninstall /kb:3081954 /quiet /norestart



:: test pour passage 8.1 vers 10
echo:
echo Enables/test upgrade from Windows 8.1 to a later version of Windows _dc W10_
echo Desinstallation de KB2976978 ...
wusa /uninstall /kb:2976978 /quiet /norestart
echo Desinstallation de KB3044374 ...
wusa /uninstall /kb:3044374 /quiet /norestart
echo Desinstallation de KB3046480 ...
wusa /uninstall /kb:3046480 /quiet /norestart
echo Desinstallation de KB3112336 - passage de win 8.1 vers win 10
wusa /uninstall /kb:3112336 /quiet /norestart

echo Desinstallation de kb3014460 - passage de win 8.1 vers win 10
wusa /uninstall /kb:3014460 /quiet /norestart

echo Desinstallation de kb3064683 - passage de win 8.1 vers win 10
wusa /uninstall /kb:3064683 /quiet /norestart
echo Desinstallation de kb3072318 - passage de win 8.1 vers win 10
wusa /uninstall /kb:3072318 /quiet /norestart
echo Desinstallation de kb3074677 - passage de win 8.1 vers win 10
wusa /uninstall /kb:3074677 /quiet /norestart
echo Desinstallation de kb3081437 - passage de win 8.1 vers win 10
wusa /uninstall /kb:3081437 /quiet /norestart
echo Desinstallation de kb3081454 - passage de win 8.1 vers win 10
wusa /uninstall /kb:3081454 /quiet /norestart

echo Desinstallation de kb3090045 - passage de win 8.1 vers win 10
wusa /uninstall /kb:3090045 /quiet /norestart

echo Desinstallation de kb3123862 - passage de win 8.1 vers win 10
wusa /uninstall /kb:3123862 /quiet /norestart

echo echo Desinstallation de kb3140185 - passage de win 8.1 vers win 10
wusa /uninstall /kb:3140185 /quiet /norestart

echo echo Desinstallation de KB3173040 - Notification fin de free upgrade towards win 10
wusa /uninstall /KB:3173040 /quiet /norestart

echo:
"%windir%"\system32\wuauclt.exe /a /DetectNow
"%windir%"\system32\wuauclt.exe /r
echo:

start "" /D "%~dp0Routines\" /wait /HIGH Riddof_GWX_FileNReg.bat
start "" /D "%~dp0Routines\" /wait /HIGH Config_NoTelemetry.bat
start "" /D "%~dp0Routines\" /wait /HIGH NoUpgrade.bat


echo:
echo lancement de %~dp0Routines\CleaningJob.bat
start "" /D "%~dp0Routines\" /wait /HIGH CleaningJob.bat

			
echo:
echo -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-_-__--_-__-
echo                    Masquage des mises a jour Indesirables
echo:
echo:

echo Permettre temporairement l'execution des scripts
:: retablie l'association de vbs avec script host car si associ‚ avec notepadplusplus par exple, alors ca marche pas
assoc .vbs=VBSFile
REG ADD "HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings" /v "Enabled" /t REG_DWORD /d 00000001 /f

echo:
echo Lancer le script pour cacher les mises jours W10 et telemetry
echo:

set "list_of_updates=KB2882822 KB2952664 KB2976978 KB2990214 KB3012973 KB3015249 KB3014460 KB3021917 KB3022345 KB3035583 KB3042058 KB3044374 KB3046480 KB3064683 KB3068708 KB3072318 KB3074677 KB3075249 KB3080149 KB3081437 KB3081454 KB3081954 KB3090045 KB3112336 KB3112343 KB3123862 KB3140185 KB3173040"

if EXIST "%~dp0Routines\HideGWXetc.vbs" (
	echo Masquage des mises a jour !list_of_updates!
	start /b /wait /HIGH cscript.exe "%~dp0Routines\HideGWXetc.vbs" !list_of_updates!
) else ( 
	echo Le fichier HideGWXetc n'a pas ete trouve.
	echo Celui-ci est necessaire pour masquer les mises a jour.
	echo Veuillez le mettre dans dossier \Routines puis relancer le programme.
)


echo:
echo Blocker l'execution des scripts
REG ADD "HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings" /v "Enabled" /t REG_DWORD /d 00000000 /f
assoc .vbs=blabla
	
if EXIST "%~dp0Routines\_dis.txt" (
	start "" /D "%~dp0Routines\" /wait /HIGH Enable-DisableWinUpdate.bat d
) else if EXIST "%~dp0Routines\_man.txt" ( 
	start "" /D "%~dp0Routines\" /wait /HIGH Enable-DisableWinUpdate.bat e
)

echo:
echo -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-_-__--_-__-
echo:
echo                               THE END
echo:
echo -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-_-__--_-__-
echo:
pause
