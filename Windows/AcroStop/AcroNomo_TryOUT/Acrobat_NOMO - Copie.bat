
net stop AdobeARMservice
sc config "AdobeARMservice" start= disabled

net stop AdobeFlashPlayerUpdateSvc
sc config "AdobeFlashPlayerUpdateSvc" start= disabled

net stop AGSService
sc config "AGSService" start= disabled


:: Disable scheduled task

schtasks /change /tn "Adobe Acrobat Update Task" /disable
schtasks /change /tn "Adobe Flash Player Updater" /disable
schtasks /change /tn "AdobeAAMUpdater-1.0-adumbrate-orko@2501" /disable

:: remove KEYS 
pause
REG DELETE HKCR\*\shellex\ContextMenuHandlers\Adobe.Acrobat.ContextMenu /f
REG DELETE HKCR\Folder\ShellEx\ContextMenuHandlers\Adobe.Acrobat.ContextMenu /f
REG DELETE HKLM\SOFTWARE\Classes\Folder\ShellEx\ContextMenuHandlers\Adobe.Acrobat.ContextMenu /f

:: Remove Values

REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved" /v "{A6595CD1-BF77-430A-A452-18696685F7C7}" /f

REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Acrobat Assistant 8.0" /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Adobe ARM" /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "AdobeAAMUpdater-1.0" /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "AdobeCEPServiceManager" /f

REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "AdobeBridge" /f

::Disable plugins in browser


IF EXIST "C:\Program Files\Adobe\Acrobat DC\Acrobat\Air\nppdf32.dll" (

del "C:\Program Files\Adobe\Acrobat DC\Acrobat\Air\Xnppdf32.dll" 
ren "C:\Program Files\Adobe\Acrobat DC\Acrobat\Air\nppdf32.dll" Xnppdf32.dll

)

IF EXIST "C:\Program Files\Adobe\Acrobat DC\Acrobat\Air\nppdf32.FRA" (

del "C:\Program Files\Adobe\Acrobat DC\Acrobat\Air\Xnppdf32.FRA" 
ren "C:\Program Files\Adobe\Acrobat DC\Acrobat\Air\nppdf32.FRA" Xnppdf32.FRA

)

IF EXIST "C:\Program Files\Adobe\Acrobat DC\Acrobat\Browser\nppdf32.dll" (

del "C:\Program Files\Adobe\Acrobat DC\Acrobat\Browser\Xnppdf32.dll" 
ren "C:\Program Files\Adobe\Acrobat DC\Acrobat\Browser\nppdf32.dll" Xnppdf32.dll

)

IF EXIST "C:\Program Files\Adobe\Acrobat DC\Acrobat\Browser\nppdf32.FRA" (

del "C:\Program Files\Adobe\Acrobat DC\Acrobat\Browser\Xnppdf32.FRA" 
ren "C:\Program Files\Adobe\Acrobat DC\Acrobat\Browser\nppdf32.FRA" Xnppdf32.FRA

)


:: Disable plugin in browser


IF EXIST "C:\Program Files\Adobe\Acrobat Reader DC\Reader\Air\nppdf32.dll" (

del "C:\Program Files\Adobe\Acrobat Reader DC\Reader\Air\Xnppdf32.dll" 
ren "C:\Program Files\Adobe\Acrobat Reader DC\Reader\Air\nppdf32.dll" Xnppdf32.dll

)

IF EXIST "C:\Program Files\Adobe\Acrobat Reader DC\Reader\Air\nppdf32.FRA" (

del "C:\Program Files\Adobe\Acrobat Reader DC\Reader\Air\Xnppdf32.FRA" 
ren "C:\Program Files\Adobe\Acrobat Reader DC\Reader\Air\nppdf32.FRA" Xnppdf32.FRA

)

IF EXIST "C:\Program Files\Adobe\Acrobat Reader DC\Reader\Browser\nppdf32.dll" (

del "C:\Program Files\Adobe\Acrobat Reader DC\Reader\Browser\Xnppdf32.dll" 
ren "C:\Program Files\Adobe\Acrobat Reader DC\Reader\Browser\nppdf32.dll" Xnppdf32.dll

)

IF EXIST "C:\Program Files\Adobe\Acrobat Reader DC\Reader\Browser\nppdf32.FRA" (

del "C:\Program Files\Adobe\Acrobat Reader DC\Reader\Browser\Xnppdf32.FRA" 
ren "C:\Program Files\Adobe\Acrobat Reader DC\Reader\Browser\nppdf32.FRA" Xnppdf32.FRA

)


:: Disable plugin in browser



IF EXIST "C:\Program Files\Common Files\Adobe\OOBE\PDApp\CCM\Utilities\npAdobeAAMDetect32.dll" (

del "C:\Program Files\Common Files\Adobe\OOBE\PDApp\CCM\Utilities\XnpAdobeAAMDetect32.dll"
ren "C:\Program Files\Common Files\Adobe\OOBE\PDApp\CCM\Utilities\npAdobeAAMDetect32.dll" XnpAdobeAAMDetect32.dll

)


IF EXIST "C:\Program Files\Common Files\Adobe\OOBE\PDApp\CCM\Utilities\npAdobeAAMDetect64.dll" (

del "C:\Program Files\Common Files\Adobe\OOBE\PDApp\CCM\Utilities\XnpAdobeAAMDetect64.dll"
ren "C:\Program Files\Common Files\Adobe\OOBE\PDApp\CCM\Utilities\npAdobeAAMDetect64.dll" XnpAdobeAAMDetect64.dll

)

:: can't work because - HKCU - user set associations override those set using ftype and assoc

FTYPE SumatraPDF="C:\Program Files\SumatraPDF\SumatraPDF.exe" "%1" %*
assoc .pdf=SumatraPDF
assoc .pdfxml=SumatraPDF
regsvr32 /i /s shell32.dll
pause
::  j'y ai cru ; je me suis acharné ...et pi non
::SCHTASKS /Create /ru system /SC ONSTART /TN ASSOPDF1 /TR "REG DELETE 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice' /v Progid /f" /F /RL HIGHEST
::SCHTASKS /Create /ru system /SC ONSTART /TN ASSOPDF2 /TR "REG ADD 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\UserChoice' /v ::Progid /t REG_SZ /d SumatraPDF /f" /F /RL HIGHEST
::SCHTASKS /run /TN ASSOPDF1
::timeout /t 2
::SCHTASKS /run /TN ASSOPDF2
::timeout /t 2
::SCHTASKS /Delete /TN ASSOPDF1 /F
::SCHTASKS /Delete /TN ASSOPDF2 /F

:: what is this wierd value - begone !
::REG DELETE "HKEY_CURRENT_USER\Software\Classes\.pdf\OpenWithProgids" /v "(par défaut)" /f

:: et voila c'est ça qui fallait faire !!
REG ADD "HKEY_CURRENT_USER\Software\Classes\.pdf\OpenWithProgids" /v "(par défaut)" /t REG_SZ /d SumatraPDF /f


pause


