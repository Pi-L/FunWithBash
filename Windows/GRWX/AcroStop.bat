echo off
pushd "%~dp0"
cls

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
::Disable plugins in browser


IF EXIST "%ProgramFiles%\Adobe\Acrobat DC\Acrobat\Air\nppdf32.dll" (
echo supprime l'extention Acrobat DC du Navigateur
echo:
del "%ProgramFiles%\Adobe\Acrobat DC\Acrobat\Air\Xnppdf32.dll" 
ren "%ProgramFiles%\Adobe\Acrobat DC\Acrobat\Air\nppdf32.dll" Xnppdf32.dll

)

IF EXIST "%ProgramFiles%\Adobe\Acrobat DC\Acrobat\Air\nppdf32.FRA" (
echo supprime aussi l'extention Acrobat DC du Navigateur
echo:
del "%ProgramFiles%\Adobe\Acrobat DC\Acrobat\Air\Xnppdf32.FRA" 
ren "%ProgramFiles%\Adobe\Acrobat DC\Acrobat\Air\nppdf32.FRA" Xnppdf32.FRA

)

IF EXIST "%ProgramFiles%\Adobe\Acrobat DC\Acrobat\Browser\nppdf32.dll" (
echo supprime l'extention Acrobat DC du Navigateur
echo:
del "%ProgramFiles%\Adobe\Acrobat DC\Acrobat\Browser\Xnppdf32.dll" 
ren "%ProgramFiles%\Adobe\Acrobat DC\Acrobat\Browser\nppdf32.dll" Xnppdf32.dll

)

IF EXIST "%ProgramFiles%\Adobe\Acrobat DC\Acrobat\Browser\nppdf32.FRA" (
echo supprime l'extention Acrobat DC du Navigateur
echo:
del "%ProgramFiles%\Adobe\Acrobat DC\Acrobat\Browser\Xnppdf32.FRA" 
ren "%ProgramFiles%\Adobe\Acrobat DC\Acrobat\Browser\nppdf32.FRA" Xnppdf32.FRA

)


:: Disable plugin in browser


IF EXIST "%ProgramFiles%\Adobe\Acrobat Reader DC\Reader\Air\nppdf32.dll" (
echo supprime l'extention Acrobat Reader DC du Navigateur
echo:
del "%ProgramFiles%\Adobe\Acrobat Reader DC\Reader\Air\Xnppdf32.dll" 
ren "%ProgramFiles%\Adobe\Acrobat Reader DC\Reader\Air\nppdf32.dll" Xnppdf32.dll

)

IF EXIST "%ProgramFiles%\Adobe\Acrobat Reader DC\Reader\Air\nppdf32.FRA" (
echo supprime l'extention Acrobat Reader DC du Navigateur
echo:
del "%ProgramFiles%\Adobe\Acrobat Reader DC\Reader\Air\Xnppdf32.FRA" 
ren "%ProgramFiles%\Adobe\Acrobat Reader DC\Reader\Air\nppdf32.FRA" Xnppdf32.FRA

)

IF EXIST "%ProgramFiles%\Adobe\Acrobat Reader DC\Reader\Browser\nppdf32.dll" (
echo supprime l'extention Acrobat Reader DC du Navigateur
echo:
del "%ProgramFiles%\Adobe\Acrobat Reader DC\Reader\Browser\Xnppdf32.dll" 
ren "%ProgramFiles%\Adobe\Acrobat Reader DC\Reader\Browser\nppdf32.dll" Xnppdf32.dll

)

IF EXIST "%ProgramFiles%\Adobe\Acrobat Reader DC\Reader\Browser\nppdf32.FRA" (
echo supprime l'extention Acrobat Reader DC du Navigateur
echo:
del "%ProgramFiles%\Adobe\Acrobat Reader DC\Reader\Browser\Xnppdf32.FRA" 
ren "%ProgramFiles%\Adobe\Acrobat Reader DC\Reader\Browser\nppdf32.FRA" Xnppdf32.FRA

)


:: Disable plugin in browser



IF EXIST "%ProgramFiles%\Common Files\Adobe\OOBE\PDApp\CCM\Utilities\npAdobeAAMDetect32.dll" (
echo supprime l'extention Adobe AAM DETECT du Navigateur
echo:
del "%ProgramFiles%\Common Files\Adobe\OOBE\PDApp\CCM\Utilities\XnpAdobeAAMDetect32.dll"
ren "%ProgramFiles%\Common Files\Adobe\OOBE\PDApp\CCM\Utilities\npAdobeAAMDetect32.dll" XnpAdobeAAMDetect32.dll

)


IF EXIST "%ProgramFiles%\Common Files\Adobe\OOBE\PDApp\CCM\Utilities\npAdobeAAMDetect64.dll" (
echo supprime l'extention Adobe AAM DETECT du Navigateur
echo:
del "%ProgramFiles%\Common Files\Adobe\OOBE\PDApp\CCM\Utilities\XnpAdobeAAMDetect64.dll"
ren "%ProgramFiles%\Common Files\Adobe\OOBE\PDApp\CCM\Utilities\npAdobeAAMDetect64.dll" XnpAdobeAAMDetect64.dll

)


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
::REG DELETE "HKEY_CURRENT_USER\Software\Classes\.pdf\OpenWithProgids" /v "(par défaut)" /f

:: et voila c'est ça qui fallait faire !! ou pas... et je sais toujours pas outputer le é de défaut.
echo tente de definir SumatraPDF comme prog par defaut pour les pdfs
echo:
REG ADD "HKEY_CURRENT_USER\Software\Classes\.pdf\OpenWithProgids" /ve /t REG_SZ /d SumatraPDF /f
REG ADD "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice" /v Progid /t REG_SZ /d SumatraPDF /f
REG ADD "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdfxml\UserChoice" /v Progid /t REG_SZ /d SumatraPDF /f


:: can't work because - HKCU - user set associations override those set using ftype and assoc

FTYPE SumatraPDF="%ProgramFiles%\SumatraPDF\SumatraPDF.exe" "%1" %*
assoc .pdf=SumatraPDF
assoc .pdfxml=SumatraPDF
regsvr32 /i /s shell32.dll


pause

exit