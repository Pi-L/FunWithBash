:: a PYL production
echo off
pushd "%~dp0"
cls
echo:


:: Dit au sys de ne plus chercher à upgrader
:: en 64 bit un DWORD est un QWORD - mais y a peut-etre les 2
:: à verifier et eventuellement utiliser la var process

echo Desactiver OSUPGRADE _a reactiver pour passer de 7 a 8.1_
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /v "AllowOSUpgrade" /t REG_DWORD /d 00000000 /f

REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade\State" /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade\State" /v "OSUpgradeState" /t REG_DWORD /d 00000001 /f

echo idem mais en lien avec gpedit.msc
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" /t REG_DWORD /d 00000001 /f



exit