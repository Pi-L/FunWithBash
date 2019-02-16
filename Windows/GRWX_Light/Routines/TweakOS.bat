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
echo desactive le service SERVER
sc config "LanmanServer" start= DISABLED

echo hide computer name in network and more lanmanserver
REG ADD "HKLM\SYSTEM\ControlSet001\Services\lanmanserver\parameters" /f /v hidden /t REG_DWORD /d 1
REG ADD "HKLM\SYSTEM\ControlSet001\Services\lanmanserver\parameters" /f /v restrictnullsessaccess /t REG_DWORD /d 1
REG ADD "HKLM\SYSTEM\ControlSet001\Services\lanmanserver\parameters" /f /v Lmannounce /t REG_DWORD /d 0

echo desactive le service registre a distance
sc config "RemoteRegistry" start= DISABLED
echo desactive le service Telnet
sc config "TlntSvr" start= DISABLED
echo desactive le service UPNP Host
sc config "upnphost" start= DISABLED
echo desactive le service SSDP Discovery
sc config "SSDPSRV" start= DISABLED
echo desactive le service de session secondaire
sc config "seclogon" start= DISABLED


echo desactive le service NetMeeting Remote Desktop Sharing
sc config "mnmsrvc" start= DISABLED
echo desactive le service Remote Desktop Services
sc config "TermService" start= DISABLED
echo desactive le service Remote Desktop Help Session Manager 
sc config "RDSessMgr" start= DISABLED
echo desactive le service Remote Desktop Configuration 
sc config "SessionEnv" start= DISABLED
echo desactive le service Windows Remote Management 
sc config "WinRM" start= DISABLED

::echo desactive le service Remote Access Connection Manager
::sc config "RasMan" start= DISABLED
echo desactive le service Routing and Remote Access _verif si ne pose pas pb qd desactive_ 
sc config "RemoteAccess" start= DISABLED
echo desactive le service Remote Access Auto Connection Manager 
sc config "RasAuto" start= DISABLED
:: peut etre utile
echo desactive le service Internet Connection Sharing 
sc config "SharedAccess" start= DISABLED

REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "CreateEncryptedOnlyTickets" /t REG_DWORD /d 00000001 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowFullControl" /t REG_DWORD /d 00000000 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 00000000 /f


echo desactive le service SNMP _eventuellement supprimer ce service_
sc config "SNMP" start= DISABLED
echo desactive le service SNMP Trap _eventuellement supprimer ce service_
sc config "SNMPTRAP" start= DISABLED

echo desactive le service d'indexation - windows search
sc config "WSearch" start= DISABLED

echo desactive le service d'Assistance NetBIOS sur TCP/IP
sc config "lmhosts" start= DISABLED

echo desactive le service Peer Networking Identity Manager
sc config "p2pimsvc" start= DISABLED
echo desactive le service Peer Networking Grouping
sc config "p2psvc" start= DISABLED
echo desactive le service Peer Networking Group Authentication
sc config "p2pgasvc" start= DISABLED
echo desactive le service Peer Name Resolution Protocol
sc config "PNRPsvc" start= DISABLED

echo desactive le service BranchCache _intended for a remote corporate user_
sc config "PeerDistSvc" start= DISABLED

echo desactive le service BranchCache _intended for a remote corporate user_
sc config "PeerDistSvc" start= DISABLED


echo desactive le service Fast User Switching Compatibility
sc config "FastUserSwitchingCompatibility" start= DISABLED

echo desactive le service FAX
sc config "Fax" start= DISABLED

echo desactive le service Web Management Service
sc config "WMSVC" start= DISABLED

echo desactive le service Windows Live Family Safety
sc config "fsssvc" start= DISABLED
echo desactive le service Family Safety
sc config "WPCSvc" start= DISABLED

echo --- disable windows media center / media player services ---
echo desactive le service Windows Media Player Network Sharing Service
sc config "WMPNetworkSvc" start= DISABLED
echo desactive le service Windows Media Center Service Launcher
sc config "ehstart" start= DISABLED
echo desactive le service Windows Media Center Scheduler Service
sc config "ehSched" start= DISABLED
echo desactive le service Windows Media Center Receiver Service
sc config "ehRecvr" start= DISABLED
echo desactive le service Windows Media Center Extender Service
sc config "Mcx2Svc" start= DISABLED
:: peut etre utile
echo desactive le service Portable Media Serial Number Service
sc config "WmdmPmSN" start= DISABLED


echo desactive le service Portable Device Enumerator Service
sc config "WPDBusEnum" start= DISABLED

echo desactive le service Problem Reports and Solutions Control Panel Support
sc config "wercplsupport" start= DISABLED
echo desactive le service Performance Logs and Alerts
sc config "SysmonLog" start= DISABLED
echo desactive le service Performance Logs and Alerts 2
sc config "pla" start= DISABLED
echo desactive le service Error Reporting Service
sc config "ERSvc" start= DISABLED




echo passe en "manuel" le service Application Host Helper Service
sc config "AppHostSvc" start= DEMAND

::echo passe en "manuel" le service Computer Browser
::sc config "Browser" start= DEMAND
::NET STOP 'Browser'

echo desactive le service Adobe Genuine Software Integrity Service
sc config "AGSService" start= DISABLED

::echo passe en "manuel" le service Bonjour
::sc config "Bonjour Service" start= DEMAND
::NET STOP 'Bonjour Service'
echo passe en "disabled" le service Bonjour
sc config "Bonjour Service" start= DISABLED


echo supprime le service google update part 1
REG DELETE "HKLM\SYSTEM\CurrentControlSet\services\gupdate" /f
echo supprime le service google update part 2
REG DELETE "HKLM\SYSTEM\CurrentControlSet\services\gupdatem" /f

echo --- desactive les service de blueToof ---
echo Bluetooth Enumerator Service
sc config "BthEnum" start= DISABLED
echo Bluetooth Serial Communications Driver
sc config "BTHMODEM" start= DISABLED
echo Bluetooth Device _Personal Area Network_
sc config "BthPan" start= DISABLED
echo Bluetooth Port Driver
sc config "BTHPORT" start= DISABLED
echo Intel_R_ Centrino_R_ Wireless Bluetooth_R_ _ High Speed Security Service
sc config "BTHSSecurityMgr" start= DISABLED
echo Bluetooth Radio USB Driver
sc config "BTHUSB" start= DISABLED
echo Bluetooth Support Service
sc config "bthserv" start= DISABLED
echo:


echo:
echo desactive la tache \Microsoft\Windows\UPnP\UPnPHostConfig
echo:
schtasks /change /tn "\Microsoft\Windows\UPnP\UPnPHostConfig" /disable

echo:
echo creer le dossier GodMode sur le bureau - administration system
mkdir "%USERPROFILE%"\desktop\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}

echo:
echo desactiver l'utilisateur guest /invite
Net User guest /active:no
Net User invite /active:no

echo:
echo verifie si le disque systeme a besoin d'un chkdisk et le planifie si necessaire
fsutil dirty query %homedrive%

if %errorlevel% NEQ 0 (
	REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "BootExecute" /t REG_MULTI_SZ /d "Autocheck autochk /p \??\%homedrive%" /f
	echo CHKDSK /f Planifie au prochain demarrage
) else (echo All is good)
echo:

echo supprime les notification WGA
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify\WGALogon" /f

echo make sure the option panel is accessible - modif group policies -
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoFolderOptions" /t REG_DWORD /d 0 /f

echo Rend visible les extensions des fichiers
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 00000000 /f

echo Remove "Shortcut To" text on shortcuts
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /t REG_BINARY /d 00000000 /f

echo:
echo desactive SharingWizard - assistant de partage
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SharingWizardOn" /t REG_DWORD /d 00000000 /f

echo:
echo disable script host
REG ADD "HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings" /v "Enabled" /t REG_DWORD /d 00000000 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings" /v "Remote" /t REG_DWORD /d 00000000 /f


echo Disable anonymous access
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "restrictanonymous" /t REG_DWORD /d 00000001 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "restrictanonymoussam" /t REG_DWORD /d 00000001 /f

echo prevent Windows from storing a LAN manager hash of your password in Active Directory and local SAM databases
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "NoLMHash" /t REG_DWORD /d 00000001 /f
echo limit blank password use
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "LimitBlankPasswordUse" /t REG_DWORD /d 00000001 /f


echo:
echo rend probablement visible les fichiers systeme
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "showsuperhidden" /t REG_DWORD /d 00000001 /f

echo:
echo Rend visible les fichiers et dossiers caches - 2 pour cacher -
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 00000001 /f

echo:
echo Rend visible "Executer" dans le menu demarrer
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_ShowRun" /t REG_DWORD /d 00000001 /f

echo:
echo Ajoute AdminTools au menu demarrer
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "StartMenuAdminTools" /t REG_DWORD /d 00000001 /f


echo:
echo AlwaysShowMenus in folders
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "AlwaysShowMenus" /t REG_DWORD /d 00000001 /f

echo:
echo active la barre d'etat dans les dossiers windows
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowStatusBar" /t REG_DWORD /d 00000001 /f

echo:
echo active la barre d'etat dans notepad
REG ADD "HKCU\Software\Microsoft\Notepad" /v "StatusBar" /t REG_DWORD /d 00000001 /f

echo:
echo trick windows into accepting every folder as documents cad details
REG ADD "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /V "FolderType" /T REG_SZ /D Documents /F
::
echo maybe to see the Attributes column in all sub-folders of a certain directory
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowAttribCol" /T REG_DWORD /D 1 /F
::


echo:
echo hide recently opened Documents from the Start menu
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 00000000 /f

echo:
echo clear recent docs on exit
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "ClearRecentDocsOnExit" /t REG_DWORD /d 00000001 /f

echo:
echo Disable Recent Docs Net Hood
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoRecentDocsNetHood" /t REG_DWORD /d 00000001 /f


echo:
echo add a Documents shortcut to the start menu
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_ShowMyDocs" /t REG_DWORD /d 00000001 /f

echo:
echo Don't randomly open copies of windows explorer when I login
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "PersistBrowsers" /t REG_DWORD /d 00000000 /f

echo:
echo ----------------------------- Disabling AUTORUN et AUTOPLAY -------------------------------------------
echo:
echo disabling autoplay - maybe
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v "DisableAutoplay" /t REG_DWORD /d 00000001 /f

echo:
echo Disable autorun - might have secondary effects on hotkeys ---------------------------------------------------
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 255 /f

echo:
echo ----- CAS par cas
echo EventHandlersDefaultSelection
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\AutorunINFLegacyArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\HandleBDBurningOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\HandleCDBurningOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\HandleDVDBurningOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\MixedContentOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\PlayBluRayOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\PlayCDAudioOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\PlayDVDAudioOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\PlayDVDMovieOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\PlayEnhancedCDOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\PlayEnhancedDVDOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\PlayMusicFilesOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\PlaySuperVideoCDMovieOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\PlayVideoCDMovieOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\PlayVideoFilesOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\ShowPicturesOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
echo UserChosenExecuteHandlers
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\AutorunINFLegacyArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\HandleBDBurningOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\HandleCDBurningOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\HandleDVDBurningOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\MixedContentOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\PlayBluRayOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\PlayCDAudioOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\PlayDVDAudioOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\PlayDVDMovieOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\PlayEnhancedCDOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\PlayEnhancedDVDOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\PlayMusicFilesOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\PlaySuperVideoCDMovieOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\PlayVideoCDMovieOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\PlayVideoFilesOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\ShowPicturesOnArrival" /ve /t REG_SZ /d "MSTakeNoAction" /f


echo:
echo ---------------------------------------------------------------------------------------------------------
echo:

echo:
echo When opening files with an unknown extension, dont prompt to search the internet
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "NoInternetOpenWith" /t REG_DWORD /d 00000001 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoInternetOpenWith" /t REG_DWORD /d 1 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "InternetOpenWith" /t REG_DWORD /d 00000000 /f

echo:
echo When transfering files, always display mor details [0 is off] - [8 et 8.1 only]
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v "ConfirmationCheckBoxDoForAll" /t REG_DWORD /d 1 /f

echo:
echo When transfering files, always check "do this for all" [0 is off] - [8 et 8.1 only]
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v "EnthusiastMode" /t REG_DWORD /d 1 /f

echo:
echo Don't use Windows NTFS link tracking to resolve existing shortcuts.
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "NoResolveTrack" /t REG_DWORD /d 00000001 /f

echo:
echo Don't display a welcome screen
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "NoWelcomeScreen" /t REG_DWORD /d 00000001 /f

Echo Turn OFF SideBar
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Windows\Sidebar" /v "TurnOffSidebar" /t REG_DWORD /d 00000001 /f

echo disable search assistant
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /v "Use Search Asst" /t REG_SZ /d NO /f

echo:
echo [0] will show all drive letters AFTER drive labels. [1] will show network drive letters BEFORE their labels. 
echo [2] will hide all drive letters. [4] will show all drive letters BEFORE drive labels.
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowDriveLettersFirst" /t REG_DWORD /d 00000004 /f
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowDriveLettersFirst" /t REG_DWORD /d 00000004 /f

echo:
echo Don't hide the log-off option from the Classic Start Menu
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ForceStartMenuLogOff" /t REG_DWORD /d 00000001 /f

echo:
echo Don't hide the log-off option from the Start Menu
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "StartMenuLogOff" /t REG_DWORD /d 00000001 /f

echo:
echo Don't hide the clock
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "HideClock" /t REG_DWORD /d 00000000 /f


echo:
echo Don't hide icons in the Notification Area
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "NoTrayItemsDisplay" /t REG_DWORD /d 00000000 /f

echo:
echo Don't Remove 'All Programs' list from the Start menu
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "NoStartMenuMorePrograms" /t REG_DWORD /d 00000000 /f

echo:
echo disable desktop CleanupWiz
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\CleanupWiz" /v "NoRun" /t REG_DWORD /d 00000001 /f

echo ------------------ MEDIA PLAYER TWEAKING ----------------

echo:
echo disable mediaplayer auto upgrade et autoupdate
REG ADD "HKLM\SOFTWARE\Microsoft\MediaPlayer" /v "EnableAutoUpgrade" /t REG_SZ /d NO /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /v "DisableAutoUpdate" /t REG_DWORD /d 00000001 /f
REG ADD HKLM\SOFTWARE\Microsoft\MediaPlayer\PlayerUpgrade /v "AskMeAgain" /t REG_SZ /d NO /f
REG ADD "HKCU\Software\Policies\Microsoft\Preferences" /v "UpgradeCodecPrompt" /t REG_DWORD /d 00000000 /f

echo make sure on can uninstall wmp
REG ADD HKLM\SOFTWARE\Microsoft\MediaPlayer /v "BlockUninstall" /t REG_SZ /d NO /f

REG ADD "HKLM\SOFTWARE\Microsoft\MediaPlayer\PREFERENCES\HME\%SID%" /v "ForceUsageTracking" /t REG_DWORD /d 00000000 /f
REG ADD "HKLM\SOFTWARE\Microsoft\MediaPlayer\PREFERENCES\HME\%SID%" /v "RemoteSharingEnabled" /t REG_DWORD /d 00000000 /f
REG ADD "HKLM\SOFTWARE\Microsoft\MediaPlayer\PREFERENCES\HME\%SID%" /v "UsageTracking" /t REG_DWORD /d 00000000 /f
REG ADD "HKLM\SOFTWARE\Microsoft\MediaPlayer\PREFERENCES\HME\%SID%" /v "AcceptedPrivacyStatement" /t REG_DWORD /d 00000000 /f

REG ADD "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "SilentAcquisition" /t REG_DWORD /d 00000000 /f
REG ADD "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AutoAddMusicToLibrary" /t REG_DWORD /d 00000000 /f
REG ADD "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "MetadataRetrieval" /t REG_DWORD /d 00000000 /f
REG ADD "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d 00000000 /f
REG ADD "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "ForceUsageTracking" /t REG_DWORD /d 00000000 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /v "disableAutoUpdate" /t REG_DWORD /d 00000001 /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /v "disableMRU" /t REG_DWORD /d 00000001 /f
REG ADD "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "CDRecordDRM" /t REG_DWORD /d 00000000 /f

REG ADD "HKEY_USERS\%SID%\Software\Microsoft\Windows Media\WMSDK\General" /v "ComputerName" /t REG_SZ /d "" /f
REG ADD "HKEY_USERS\%SID%\Software\Microsoft\Windows Media\WMSDK\General" /v "UniqueID" /t REG_SZ /d 0 /f

echo --------------- end MP Tweaking ---------------------------


echo:
echo Auto Restart Explorer After Crash
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoRestartShell" /t REG_DWORD /d 00000001 /f



echo:
echo Beep On Errors
REG ADD "HKCU\Control Panel\Sound" /v "Beep" /t REG_DWORD /d 00000000 /f
REG ADD "HKCU\Control Panel\Sound" /v "ExtendedSounds" /t REG_DWORD /d 00000000 /f

echo:
echo make control panel behave
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "ForceClassicControlPanel" /t REG_DWORD /d 00000001 /f

echo:
echo Change le profil de son -sound scheme- to NO SOUND and make it stick...maybe
REG ADD "HKCU\AppEvents\Schemes" /ve /t REG_SZ /d ".None" /f
echo ---------------------- current -----------------
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\.Default\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\AppGPFault\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\CCSelect\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\Close\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\ChangeTheme\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\CriticalBatteryAlarm\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\DeviceConnect\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\DeviceDisconnect\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\DeviceFail\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\FaxBeep\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\LowBatteryAlarm\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\MailBeep\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\Maximize\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\MenuCommand\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\MenuPopup\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\Minimize\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\Open\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\PrintComplete\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\RestoreDown\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\RestoreUp\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\ShowBand\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\SystemAsterisk\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\SystemExclamation\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\SystemExit\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\SystemHand\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\SystemNotification\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\SystemQuestion\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\WindowsLogoff\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\WindowsLogon\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\WindowsUAC\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\ActivatingDocument\.current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\BlockedPopup\.current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\EmptyRecycleBin\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\FaxError\.current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\FaxLineRings\.current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\FaxSent\.current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\FeedDiscovered\.current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\MoveMenuItem\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\Navigating\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\SearchProviderDiscovered\.Current" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\SecurityBand\.current" /ve /t REG_SZ /d "" /f
echo:
echo -------------------- none -----------------
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\.Default\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\AppGPFault\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\CCSelect\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\Close\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\ChangeTheme\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\CriticalBatteryAlarm\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\DeviceConnect\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\DeviceDisconnect\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\DeviceFail\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\FaxBeep\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\LowBatteryAlarm\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\MailBeep\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\Maximize\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\MenuCommand\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\MenuPopup\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\Minimize\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\Open\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\PrintComplete\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\RestoreDown\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\RestoreUp\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\ShowBand\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\SystemAsterisk\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\SystemExclamation\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\SystemExit\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\SystemHand\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\SystemNotification\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\SystemQuestion\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\WindowsLogoff\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\WindowsLogon\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\.Default\WindowsUAC\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\ActivatingDocument\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\BlockedPopup\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\EmptyRecycleBin\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\FaxError\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\FaxLineRings\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\FaxSent\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\FeedDiscovered\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\MoveMenuItem\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\Navigating\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\SearchProviderDiscovered\.None" /ve /t REG_SZ /d "" /f
REG ADD "HKCU\AppEvents\Schemes\Apps\Explorer\SecurityBand\.None" /ve /t REG_SZ /d "" /f
echo:

:: pour le diaporama -slideshow- ca a l'air de pas pouvoir ce faire via le registre
:: y a %USERPROFILE%\AppData\Roaming\Microsoft\Windows\Themes\slideshow.ini possiblement -or not- modifiable...
:: la y a des truc sur le screen saver "HKCU\Control Panel\Desktop"

echo:
echo Change le profil du screensaver en "vierge" - blank-
echo pour mettre aucun, supprimer cette clef
REG ADD "HKCU\Control Panel\Desktop" /v SCRNSAVE.EXE /t REG_SZ /d "%SYSTEMROOT%\System32\scrnsave.scr" /f


:: %SYSTEMROOT%\System32\rundll32.exe %SYSTEMROOT%\System32\user32.dll, UpdatePerUserSystemParameters
:: this doesn' appear to work - need to logon again for change to take place

:: suricats !
REM copy "%~dp0Suricat_Wallpaper.jpeg" "%HOMEPATH%\Pictures\Suricat_Wallpaper.jpeg"
REM SET "walp=%HOMEPATH%\Pictures\Suricat_Wallpaper.jpeg"
REM REG ADD "HKCU\Control Panel\Desktop" /v Wallpaper /f /t REG_SZ /d %walp%

echo:
echo ---------------- power management ------------
echo:
echo maximum perf - minimum battery
powercfg -setactive SCHEME_MIN

echo:
echo pas d'hybernation - a pc is not a bear
powercfg -hibernate off

:: ceci est probablement utilisable avec HKCU\Control Panel\PowerCfg

echo:
echo ------------------------------------------------


echo ------------------ internet settings -----------
echo:
echo disable ssl cache
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "DisableCachingOfSSLPages" /t REG_DWORD /d 00000001 /f

echo:
echo gestion avance des cookies
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "PrivacyAdvanced" /t REG_DWORD /d 00000001 /f

echo:
echo First Party Cookie yes
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "{AEBA21FA-782A-4A90-978D-B72164C80120}" /t REG_BINARY /d "1a3761592352350c7a5f20172f1e1a190e2b017313371312141a152a" /f

echo:
echo Third Party Cookie nono
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "{A8A88C49-5EB2-4990-A1A2-0876022C854F}" /t REG_BINARY /d "1a3761592352350c7a5f20172f1e1a190e2b017313371312141a1539" /f


echo:
echo WarnonBadCertRecving
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "WarnonBadCertRecving" /t REG_DWORD /d 00000001 /f

echo:
echo disable java
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1C00" /t REG_DWORD /d 00000000 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1605" /t REG_DWORD /d 00000003 /f

echo:
echo no stored peristant cookies or 3rd party
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1A02" /t REG_DWORD /d 0000003 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1A05" /t REG_DWORD /d 0000003 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1A06" /t REG_DWORD /d 0000003 /f

echo:
echo logon methode -
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1A00" /t REG_DWORD /d 00010000 /f

echo:
echo disallow Programmatic clipboard access
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1407" /t REG_DWORD /d 0000003 /f

echo:
echo parametrage internet explorer
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Webcheck" /v "NoScheduledUpdates" /t REG_DWORD /d 0000001 /f
REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /v "IEWatsonDisabled" /t REG_DWORD /d 0000001 /f
REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /v "IEWatsonEnabled" /t REG_DWORD /d 0000000 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "EnableNegotiate" /t REG_DWORD /d 0000000 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "MaxConnectionsPerServer" /t REG_DWORD /d 0000000 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "MaxConnectionsPer1_0Server" /t REG_DWORD /d 0000000 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Cache" /v "Persistent" /t REG_DWORD /d 0000000 /f
REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Use FormSuggest" /t REG_DWORD /d 0000000 /f
REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /v "FormSuggest Passwords" /t REG_DWORD /d 0000000 /f
REG ADD "HKCU\Software\Microsoft\Internet Explorer\PhishingFilter" /v "Enabled" /t REG_SZ /d "0" /f
REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Use Search Asst" /t REG_SZ /d "no" /f
REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Do404Search" /t REG_SZ /d "01000000" /f
REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /t REG_SZ /d "about:blank" /f
REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Check_Associations" /t REG_SZ /d "no" /f
REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Disable Script Debugger" /t REG_SZ /d "yes" /f
REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /v "DisableScriptDebuggerIE" /t REG_SZ /d "no" /f
REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Play_Animations" /t REG_SZ /d "no" /f
REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Save_Session_History_On_Exit" /t REG_SZ /d "no" /f
REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /v "DoNotTrack" /t REG_DWORD /d 0000001 /f
REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /v "DOMStorage" /t REG_DWORD /d 0000000 /f
REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /v "NoUpdateCheck" /t REG_DWORD /d 0000001 /f

REG ADD "HKEY_USERS\%SID%\Software\Microsoft\Internet Explorer\Privacy" /v "CleanDownloadHistory" /t REG_DWORD /d 1 /f
REG ADD "HKEY_USERS\%SID%\Software\Microsoft\Internet Explorer\Privacy" /v "CleanForms" /t REG_DWORD /d 1 /f
REG ADD "HKEY_USERS\%SID%\Software\Microsoft\Internet Explorer\Privacy" /v "CleanPassword" /t REG_DWORD /d 1 /f
REG ADD "HKEY_USERS\%SID%\Software\Microsoft\Internet Explorer\Privacy" /v "ClearBrowsingHistoryOnExit" /t REG_DWORD /d 1 /f
:: Automatic logon

REM HKLM\Software\Microsoft\Windows NT\CurrentVersion\winlogon
REM AutoAdminLogon = "1" Enabled  (To disable Auto Logon set to value to zero)
REM DefaultUserName = "xxx"
REM DefaultPassword = "xxxx0xxxx"
REM DefaultDomainName = "xxx.xxx".  Only needed if computer has joined a domain.
REM REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableRegistryTools /t REG_DWORD /d 0000002 /f
REM Le "2" desactive en plus l'execution silencieuse du registre ... apres allez savoir ce que ca veut dire ^^
REM de plus ca n'empeche pas l'acces au registre via des appli tierce
REM Pour re-activer regedit, utiliser gpedit.msc


:: achecker
:: HKEY_CURRENT_USER\Software\Microsoft\Windows\Windows Error Reporting

:: associate .zip with windows compressed folders
:: assoc .zip=CompressedFolder
:: regsvr32 zipfldr.dll

echo disable windows zip folders

echo ----- kaspersky pense que c est un trojan ... 

:: use of REGINI to take ownership of regkey

REM echo '\Registry\machine\software\classes\CLSID\{E88DCCE0-B7B3-11d1-A9F0-00AA0060FA31}' [1 6 17]>"%homepath%\Desktop\rr.txt"
REM REGINI "%homepath%\Desktop\rr.txt"
REM REG DELETE "HKCR\CLSID\{E88DCCE0-B7B3-11d1-A9F0-00AA0060FA31}" /f

REM echo '\Registry\machine\software\classes\CLSID\{0CD7A5C0-9F37-11CE-AE65-08002B2E1262}' [1 6 17]>"%homepath%\Desktop\rr.txt"
REM REGINI "%homepath%\Desktop\rr.txt"
REM DEL /f "%homepath%\Desktop\rr.txt"

REM REG DELETE "HKCR\CLSID\{0CD7A5C0-9F37-11CE-AE65-08002B2E1262}" /f

REM regsvr32 /u /s "%windir%\system32\zipfldr.dll"




	


exit