:: a PYL production
echo off
pushd "%~dp0"
cls
echo:

echo:
echo -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-_-__--_-__-

:: vire l'appli get windows X
echo                          ByeBye "Get Windows X"
echo:
echo:

echo Kill GWX.exe
Taskkill /F /T /IM gwx.exe

:: finir takedown par "o" en français, et "y" en anglais _reponse auto si prompt_
echo:
echo Supprime %SYSTEMROOT%\System32\GWX
if EXIST "%SYSTEMROOT%\System32\GWX" (
	takeown /f "%SYSTEMROOT%\System32\GWX" /r /d o
	icacls "%SYSTEMROOT%\System32\GWX" /grant administrators:F /t
	rmdir /s /q "%SYSTEMROOT%\System32\GWX\"
) else (echo n'existe pas ou deja supprime)

echo:
echo Supprime %SYSTEMROOT%\SysWOW64\GWX
if EXIST "%SYSTEMROOT%\SysWOW64\GWX" (
	takeown /f "%SYSTEMROOT%\SysWOW64\GWX" /r /d o
	icacls "%SYSTEMROOT%\SysWOW64\GWX" /grant administrators:F /t
	rmdir /s /q "%SYSTEMROOT%\SysWOW64\GWX"
) else (echo n'existe pas ou deja supprime)

echo:
echo Supprime %homedrive%\$Windows~BT
if EXIST "%homedrive%\$Windows~BT" (
	takeown /f "%homedrive%\$Windows~BT" /r /d o
	icacls "%homedrive%\$Windows~BT" /grant administrators:F /t
	rmdir /s /q "%homedrive%\$Windows~BT\"
) else (echo n'existe pas ou deja supprime)

echo:
echo:
echo Supprime le contenu de %SYSTEMROOT%\SoftwareDistribution\Download
echo ----------
if EXIST "%SYSTEMROOT%\SoftwareDistribution\Download" (
	takeown /f "%SYSTEMROOT%\SoftwareDistribution\Download" /r /d o
	icacls "%SYSTEMROOT%\SoftwareDistribution\Download" /grant administrators:F /t
	for /d %%i in ("%SYSTEMROOT%"\SoftwareDistribution\Download\*) do rd /s /q "%%i"
		del /s /q "%SYSTEMROOT%"\SoftwareDistribution\Download\*.*
) else (echo n'existe pas)

echo ----------
echo:
echo:
echo Supprime %SYSTEMROOT%\System32\Tasks\Microsoft\Windows\Setup\gwx
if EXIST "%SYSTEMROOT%\System32\Tasks\Microsoft\Windows\Setup\gwx" (
	takeown /f "%SYSTEMROOT%\System32\Tasks\Microsoft\Windows\Setup\gwx" /r /d o
	icacls "%SYSTEMROOT%\System32\Tasks\Microsoft\Windows\Setup\gwx" /grant administrators:F /t
	rmdir /s /q "%SYSTEMROOT%\System32\Tasks\Microsoft\Windows\Setup\gwx"
) else (echo n'existe pas ou deja supprime)

echo:
echo Supprime %SYSTEMROOT%\System32\Tasks\Microsoft\Windows\Setup\GWXTriggers
if EXIST "%SYSTEMROOT%\System32\Tasks\Microsoft\Windows\Setup\GWXTriggers" (
	takeown /f "%SYSTEMROOT%\System32\Tasks\Microsoft\Windows\Setup\GWXTriggers" /r /d o
	icacls "%SYSTEMROOT%\System32\Tasks\Microsoft\Windows\Setup\GWXTriggers" /grant administrators:F /t
	rmdir /s /q "%SYSTEMROOT%\System32\Tasks\Microsoft\Windows\Setup\GWXTriggers"
) else (echo n'existe pas ou deja supprime)

echo:
echo Supprime %LOCALAPPDATA%\GWX
if EXIST "%LOCALAPPDATA%\GWX" (
	takeown /f "%LOCALAPPDATA%\GWX" /r /d o
	icacls "%LOCALAPPDATA%\GWX" /grant administrators:F /t
	rmdir /s /q "%LOCALAPPDATA%\GWX"
) else (echo n'existe pas ou deja supprime)

:: ca c'est un peu . a la one again mais enfin ca marche ! _et ca fait plaisir_ - et c'est reutilisable...
echo:
echo creation de 2 taches _as sys with highest rights_ pour...

SCHTASKS /Create /ru system /SC ONSTART /TN ByeGWX1 /TR "REG DELETE 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\Setup\gwx' /f" /F /RL HIGHEST

SCHTASKS /Create /ru system /SC ONSTART /TN ByeGWX2 /TR "REG DELETE 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GWX' /f" /F /RL HIGHEST

echo:
echo Supprimer HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\Setup\gwx
SCHTASKS /run /TN ByeGWX1
timeout /t 2
SCHTASKS /Delete /TN ByeGWX1 /F
echo:
echo Supprimer HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GWX
SCHTASKS /run /TN ByeGWX2
timeout /t 2
SCHTASKS /Delete /TN ByeGWX2 /F

echo:
echo suppression dans le registre des lien de telechargment de GWX
REG DELETE "HKLM\SYSTEM\Setup\GWX" /f


echo -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-_-__--_-__-
echo:


echo:
echo creer la valeur DisableGwx _1_ dans le registre
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\GWX" /f
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\GWX" /v "DisableGwx" /t REG_DWORD /d 00000001 /f


exit