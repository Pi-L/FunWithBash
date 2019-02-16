:: a PYL production
echo off
pushd "%~dp0"
cls
echo:

echo:
echo UI - Passe les mises a jour en automatique et auto install
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 4 /f


echo:
echo Logged-on user can decide whether to restart the client computer.
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoRebootWithLoggedOnUsers" /t REG_DWORD /d 00000001 /f

echo:
::echo GP - Automatically download and schedule installation.for ScheduledInstallDay and ScheduledInstallTime.
::REG ADD HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v "AUOptions" /t REG_DWORD /d 00000004 /f
echo Delete AUOptions
REG Delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /f

echo:
echo schedule installation : Every day
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "ScheduledInstallDay" /t REG_DWORD /d 00000000 /f

echo:
echo schedule installation : a 21h
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "ScheduledInstallTime" /t REG_DWORD /d 21 /f

echo:
echo  Silently install minor updates.
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AutoInstallMinorUpdates" /t REG_DWORD /d 00000001 /f

echo:
echo Enable Automatic Updates
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 00000000 /f

echo:
echo Enable RebootRelaunchTimeout
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "RebootRelaunchTimeoutEnabled" /t REG_DWORD /d 1 /f

echo:
echo Time between prompts for a scheduled restart. 440 min.
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "RebootRelaunchTimeout" /t REG_DWORD /d 440 /f

echo:
echo The WSUS server does not distribute available signed non-Microsoft updates.
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "AcceptTrustedPublisherCerts" /t REG_DWORD /d 00000000 /f



exit