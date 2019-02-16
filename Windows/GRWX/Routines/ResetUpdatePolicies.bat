:: a PYL production
echo off
pushd "%~dp0"
cls
echo:
echo:
echo Logged-on user can decide whether to restart the client computer.
REG ADD HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v "NoAutoRebootWithLoggedOnUsers" /t REG_DWORD /d 00000001 /f

echo:
echo GP - Automatically download and schedule installation.for ScheduledInstallDay and ScheduledInstallTime.
REG DELETE HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v "AUOptions" /f

echo:
echo schedule installation : Every day
REG DELETE HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v "ScheduledInstallDay" /f

echo:
echo schedule installation : a 21h
REG DELETE HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v "ScheduledInstallTime" /f

echo:
echo  Silently install minor updates.
REG DELETE HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v "AutoInstallMinorUpdates" /f

echo:
echo Enable Automatic Updates
REG DELETE HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v "NoAutoUpdate" /f

echo:
echo Enable RebootRelaunchTimeout
REG DELETE HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v "RebootRelaunchTimeoutEnabled" /f

echo:
echo Time between prompts for a scheduled restart. 440 min.
REG DELETE HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v "RebootRelaunchTimeout" /f

echo:
echo The WSUS server does not distribute available signed non-Microsoft updates.
REG DELETE HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /v "AcceptTrustedPublisherCerts" /f

echo:
echo UI - Passe les mises a jour en auto
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 4 /f



exit