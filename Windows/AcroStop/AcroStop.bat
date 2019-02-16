:: a PYL production
pushd "%~dp0"
echo off
setlocal EnableDelayedExpansion
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


echo Kill acrotray
Taskkill /F /T /IM acrotray.exe

echo:
echo stop et supprime AdobeARMservice
echo:
net stop AdobeARMservice
sc config "AdobeARMservice" start= disabled

echo:
echo stop et supprime AdobeFlashPlayerUpdateSvc
echo:
net stop AdobeFlashPlayerUpdateSvc
sc config "AdobeFlashPlayerUpdateSvc" start= disabled

echo:
echo stop et supprime AGSService
echo:
net stop AGSService
sc config "AGSService" start= disabled


:: Disable scheduled task
echo:
echo Disable Adobe Acrobat Update Task
echo:
schtasks /change /tn "Adobe Acrobat Update Task" /disable
echo:
echo Disable Adobe Flash Player Updater Task
echo:
schtasks /change /tn "Adobe Flash Player Updater" /disable
echo:
echo Disable AdobeAAMUpdater-1.0-adumbrate Task
echo:
schtasks /change /tn "AdobeAAMUpdater-1.0-adumbrate-orko@2501" /disable
echo:
echo Disable Adobe Flash Player PPAPI Notifier Task
echo:
schtasks /change /tn "Adobe Flash Player PPAPI Notifier" /disable

:: remove KEYS 
echo:
echo supprime acrobat du menu clic droit
REG DELETE HKCR\*\shellex\ContextMenuHandlers\Adobe.Acrobat.ContextMenu /f
REG DELETE HKCR\Folder\ShellEx\ContextMenuHandlers\Adobe.Acrobat.ContextMenu /f
REG DELETE HKLM\SOFTWARE\Classes\Folder\ShellEx\ContextMenuHandlers\Adobe.Acrobat.ContextMenu /f

:: Remove Values
echo:
echo supprime acrobat du menu clic droit
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved" /v "{A6595CD1-BF77-430A-A452-18696685F7C7}" /f

echo:
echo supprime l'execution au demarrage de Acrobat Assistant
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Acrobat Assistant 8.0" /f

REG DELETE "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" /v "Acrobat Assistant 8.0" /f

REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run32" /v "Acrobat Assistant 8.0" /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run32" /v "AdobeAAMUpdater-1.0" /f

echo:
echo supprime l'execution au demarrage de Adobe ARM
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Adobe ARM" /f
echo:
echo supprime l'execution au demarrage de AdobeAAMUpdater
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "AdobeAAMUpdater-1.0" /f
echo:
echo supprime l'execution au demarrage de AdobeCEPServiceManager
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "AdobeCEPServiceManager" /f

echo:
echo supprime l'execution au demarrage de AdobeBridge
REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "AdobeBridge" /f
echo:

echo:
echo 
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\MozillaPlugins\Adobe Acrobat" /f
echo:

echo:
echo 
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\MozillaPlugins\Adobe Reader" /f
echo:

echo:
echo 
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\MozillaPlugins\adobe.com/AdobeAAMDetect" /f
echo:


::echo set adobe flashplayerupdate start value to 4 - ca veut peut etre dire "desactive"
::REG ADD "HKLM\SYSTEM\CurrentControlSet\services\AdobeFlashPlayerUpdateSvc" /v Start /t REG_DWORD /D 4 /f
echo:
:: peut-etre plus simple de tout supprimer
echo supprime flashplayerupdate service du registre
REG DELETE "HKLM\SYSTEM\CurrentControlSet\services\AdobeFlashPlayerUpdateSvc" /f






::Disable plugins in browser - Acrobat DC


IF EXIST "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\Air\nppdf32.dll" (
	echo supprime l'extention Acrobat DC du Navigateur
	echo:
	del "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\Air\Xnppdf32.dll" 
	ren "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\Air\nppdf32.dll" Xnppdf32.dll
	echo:
)

IF EXIST "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\Air\nppdf32.FRA" (
	echo supprime aussi l'extention Acrobat DC du Navigateur
	echo:
	del "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\Air\Xnppdf32.FRA" 
	ren "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\Air\nppdf32.FRA" Xnppdf32.FRA
	echo:
)

IF EXIST "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\Browser\nppdf32.dll" (
	echo supprime l'extention Acrobat DC du Navigateur
	echo:
	del "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\Browser\Xnppdf32.dll" 
	ren "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\Browser\nppdf32.dll" Xnppdf32.dll
	echo:
)

IF EXIST "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\Browser\nppdf32.FRA" (
	echo supprime l'extention Acrobat DC du Navigateur
	echo:
	del "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\Browser\Xnppdf32.FRA" 
	ren "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\Browser\nppdf32.FRA" Xnppdf32.FRA
	echo:
)

IF EXIST "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\nppdf32.dll" (
	echo supprime l'extention Acrobat DC du Navigateur
	echo:
	del "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\Xnppdf32.dll" 
	ren "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\nppdf32.dll" Xnppdf32.dll
	echo:
)

IF EXIST "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\nppdf32.FRA" (
	echo supprime l'extention Acrobat DC du Navigateur
	echo:
	del "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\Xnppdf32.FRA" 
	ren "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\nppdf32.FRA" Xnppdf32.FRA
	echo:
)

IF EXIST "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\Browser\WCFirefoxExtn" (
	echo supprime l'extention Acrobat DC du Navigateur
	echo:
	rd /s /q "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\Browser\XWCFirefoxExtn" 
	ren "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\Browser\WCFirefoxExtn" XWCFirefoxExtn
	echo:
)

IF EXIST "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\Browser\WCChromeExtn" (
	echo supprime l'extention Acrobat DC du Navigateur
	echo:
	rd /s /q "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\Browser\XWCChromeExtn" 
	ren "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\Browser\WCChromeExtn" XWCChromeExtn
	echo:
)

:: Disable plugin in browser - Reader DC


IF EXIST "%ProgramFiles(x86)%\Adobe\Acrobat Reader DC\Reader\Air\nppdf32.dll" (
	echo supprime l'extention Acrobat Reader DC du Navigateur
	echo:
	del "%ProgramFiles(x86)%\Adobe\Acrobat Reader DC\Reader\Air\Xnppdf32.dll" 
	ren "%ProgramFiles(x86)%\Adobe\Acrobat Reader DC\Reader\Air\nppdf32.dll" Xnppdf32.dll
	echo:
)

IF EXIST "%ProgramFiles(x86)%\Adobe\Acrobat Reader DC\Reader\Air\nppdf32.FRA" (
	echo supprime l'extention Acrobat Reader DC du Navigateur
	echo:
	del "%ProgramFiles(x86)%\Adobe\Acrobat Reader DC\Reader\Air\Xnppdf32.FRA" 
	ren "%ProgramFiles(x86)%\Adobe\Acrobat Reader DC\Reader\Air\nppdf32.FRA" Xnppdf32.FRA
	echo:
)

IF EXIST "%ProgramFiles(x86)%\Adobe\Acrobat Reader DC\Reader\Browser\nppdf32.dll" (
	echo supprime l'extention Acrobat Reader DC du Navigateur
	echo:
	del "%ProgramFiles(x86)%\Adobe\Acrobat Reader DC\Reader\Browser\Xnppdf32.dll" 
	ren "%ProgramFiles(x86)%\Adobe\Acrobat Reader DC\Reader\Browser\nppdf32.dll" Xnppdf32.dll
	echo:
)

IF EXIST "%ProgramFiles(x86)%\Adobe\Acrobat Reader DC\Reader\Browser\nppdf32.FRA" (
	echo supprime l'extention Acrobat Reader DC du Navigateur
	echo:
	del "%ProgramFiles(x86)%\Adobe\Acrobat Reader DC\Reader\Browser\Xnppdf32.FRA" 
	ren "%ProgramFiles(x86)%\Adobe\Acrobat Reader DC\Reader\Browser\nppdf32.FRA" Xnppdf32.FRA
	echo:
)



:: Disable plugin in browser



IF EXIST "%ProgramFiles(x86)%\Common Files\Adobe\OOBE\PDApp\CCM\Utilities\npAdobeAAMDetect32.dll" (
	echo supprime l'extention Adobe AAM DETECT du Navigateur
	echo:
	del "%ProgramFiles(x86)%\Common Files\Adobe\OOBE\PDApp\CCM\Utilities\XnpAdobeAAMDetect32.dll"
	ren "%ProgramFiles(x86)%\Common Files\Adobe\OOBE\PDApp\CCM\Utilities\npAdobeAAMDetect32.dll" XnpAdobeAAMDetect32.dll
	echo:

)


IF EXIST "%ProgramFiles(x86)%\Common Files\Adobe\OOBE\PDApp\CCM\Utilities\npAdobeAAMDetect64.dll" (
	echo supprime l'extention Adobe AAM DETECT du Navigateur
	echo:
	del "%ProgramFiles(x86)%\Common Files\Adobe\OOBE\PDApp\CCM\Utilities\XnpAdobeAAMDetect64.dll"
	ren "%ProgramFiles(x86)%\Common Files\Adobe\OOBE\PDApp\CCM\Utilities\npAdobeAAMDetect64.dll" XnpAdobeAAMDetect64.dll
	echo:
)

:: Rage Against Telemetry
echo:
echo delete LogTransport2 dans Adobe Reader DC
del "%ProgramFiles(x86)%\Adobe\Acrobat Reader DC\Reader\LogTransport2.exe"
echo:
echo delete LogTransport2 dans Adobe InDesign
del "%ProgramFiles(x86)%\Adobe\Adobe InDesign CC 2015 (32-bit)\LogTransport2.exe"
echo:

echo delete LogTransport2 dans Adobe InDesign
del "%ProgramFiles%\Adobe\Adobe InDesign CC 2015\LogTransport2.exe"
echo:

echo delete LogTransport2 dans Photoshop CC
del "%ProgramFiles%\Adobe\Adobe Photoshop CC 2015\LogTransport2.exe"
echo

echo delete LogTransport2 dans Adobe Update Management Tool
del "%ProgramFiles(x86)%\Adobe\Update Management Tool\Res\uwa\LogTransport2.exe"
echo:

echo delete LogTransport2 dans Adobe Acrobat DC
del "%ProgramFiles(x86)%\Adobe\Acrobat DC\Acrobat\LogTransport2.exe"
echo:

REM echo delete LogTransport2 dans Adobe Bridge CC
REM del "%ProgramFiles%\Adobe\Adobe Bridge CC\LogTransport2.exe"
REM echo:
REM echo delete LogTransport2 dans Photoshop CC
REM del "%ProgramFiles%\Adobe\Adobe Photoshop CC 2014 (32 Bit)\LogTransport2.exe"
REM echo:
REM echo delete LogTransport2 dans Illustrator CC
REM del "%ProgramFiles%\Adobe\Adobe Illustrator CC\Support Files\Contents\Windows\LogTransport2.exe"
REM echo:

:: au passage - meme traitement pour foxit reader
echo:
echo Foxit Reader
echo:

IF EXIST "%ProgramFiles%\Foxit Software\Foxit Reader\plugins\npFoxitReaderPlugin.dll" (
	echo supprime l'extention Foxit Reader BrowserIntegration
	echo:
	del "%ProgramFiles%\Foxit Software\Foxit Reader\plugins\XnpFoxitReaderPlugin.dll" 
	ren "%ProgramFiles%\Foxit Software\Foxit Reader\plugins\npFoxitReaderPlugin.dll" XnpFoxitReaderPlugin.dll
)

IF EXIST "%ProgramFiles%\Foxit Software\Foxit Reader\plugins\FoxitReaderBrowserAx.dll" (
	echo supprime l'extention Foxit Reader - bis
	echo:
	del "%ProgramFiles%\Foxit Software\Foxit Reader\plugins\XFoxitReaderBrowserAx.dll" 
	ren "%ProgramFiles%\Foxit Software\Foxit Reader\plugins\FoxitReaderBrowserAx.dll" XFoxitReaderBrowserAx.dll
)
echo:

:: {CA8A9780-280D-11CF-A24D-444553540000} has to do with adobe plugin

::  j'y ai cru ; je me suis acharné ...et pi non
::SCHTASKS /Create /ru system /SC ONSTART /TN ASSOPDF1 /TR "REG DELETE 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice' /v Progid /f" /F /RL HIGHEST
::SCHTASKS /Create /ru system /SC ONSTART /TN ASSOPDF2 /TR "REG ADD 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice' /v ::Progid /t REG_SZ /d SumatraPDF /f" /F /RL HIGHEST
::SCHTASKS /run /TN ASSOPDF1
::timeout /t 2
::SCHTASKS /run /TN ASSOPDF2
::timeout /t 2
::SCHTASKS /Delete /TN ASSOPDF1 /F
::SCHTASKS /Delete /TN ASSOPDF2 /F

:: 
::REG DELETE "HKCU\Software\Classes\.pdf\OpenWithProgids" /v "(par défaut)" /f

:: et voila c'est ça qui fallait faire !! ou pas... et je sais toujours pas outputer le é de défaut.
echo tente de definir SumatraPDF comme prog par defaut pour les pdfs
:: a bit overkill but works
echo:
REG ADD "HKCU\Software\Classes\.pdf\OpenWithProgids" /ve /t REG_SZ /d SumatraPDF /f
REG ADD "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice" /v Progid /t REG_SZ /d SumatraPDF /f
REG ADD "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdfxml\UserChoice" /v Progid /t REG_SZ /d SumatraPDF /f
REG ADD "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice" /v Hash /t REG_SZ /d "T27qpZ1dtD0=" /f
REG ADD "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdfxml\UserChoice" /v Hash /t REG_SZ /d "vQgJnBpyRRo=" /f
REG ADD "HKCR\MIME\DataBase\Content Type\application/pdf" /ve /t REG_SZ /d SumatraPDF /f

REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf" /ve /t REG_SZ /d SumatraPDF.exe /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice" /v Progid /t REG_SZ /d SumatraPDF /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdfxml\UserChoice" /v Progid /t REG_SZ /d SumatraPDF /f
REG ADD "HKLM\SOFTWARE\Classes\MIME\Database\Content Type\application/pdf" /ve /t REG_SZ /d SumatraPDF /f
echo User ID spesific entries
REG ADD "HKEY_USERS\%SID%\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice" /v Progid /t REG_SZ /d SumatraPDF /f
REG ADD "HKEY_USERS\%SID%\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice" /v Hash /t REG_SZ /d "T27qpZ1dtD0=" /f
REG ADD "HKEY_USERS\%SID%\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdfxml\UserChoice" /v Progid /t REG_SZ /d SumatraPDF /f
REG ADD "HKEY_USERS\%SID%\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdfxml\UserChoice" /v Hash /t REG_SZ /d "vQgJnBpyRRo=" /f

:: can't work because - HKCU - user set associations override those set using ftype and assoc

FTYPE SumatraPDF="%ProgramFiles%\SumatraPDF\SumatraPDF.exe" "%1" %*
assoc .pdf=SumatraPDF
assoc .pdfxml=SumatraPDF
assoc .djvu=SumatraPDF
regsvr32 /i /s shell32.dll


exit