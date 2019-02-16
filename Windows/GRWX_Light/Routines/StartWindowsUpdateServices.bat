:: a PYL production
echo off
pushd "%~dp0"
cls
echo:
echo:

echo demarre windows update and co
echo:

echo Mode Manuel et Demarrage du service TrustedInstaller
sc config "TrustedInstaller"  start= demand
net start TrustedInstaller

echo:
echo Mode Manuel et Demarrage du service BITS
sc config "BITS"  start= demand
net start BITS

echo:
echo Mode auto et Demarre service Windows Update
sc config "wuauserv" start= auto
net start wuauserv
	

exit