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
:: recuperation des arguments
set ChoixMenu=0
set "ChxAdvMenu=0"
set HasProperValue=0
set HasProperValueAgain=0
set upupon=0
set byebyeups=0

set one=0
set two=0
set three=0
set four=0
set five=0
set six=0
set seven=0
set eight=0
set nine=0
set A1=0
set A2=0
set A3=0
set A4=0
set A5=0

set "arg1=%1"

if [!arg1!] NEQ [] ( set "ChoixMenu=!arg1!" )
::if [%2] NEQ [] ( Set WUPWUP=%2
::) else ( 
::	if %ChoixMenu% == menu ( Set WUPWUP=menu )
::)

:: Afficher un menu
if %ChoixMenu% == menu (
:Menu_Origin
	echo:
	echo -------------------------- MENU OPTIONS -------------------------------------
	echo: 
	echo  1/ No GWX, , 
	echo  2/ No Upgrading
	echo  3/ No Telemetry
	echo  4/ ConfigWU policies
	echo  5/ Extra Tweaks
	echo  6/ House Cleaning
	echo  7/ Disable WinUpdate at the end
	echo  8/ EVERYTHING
	echo  9/ Menu Avanced User       / le choix 9 est forcement seul /
	echo  q/ Quitter
	
	echo:
	echo:
	Set /p "ChoixMenu=Saisir vos choix [vous pouvez en combiner plusieurs. Sauf 9. ex: 146] : "
	
	if "!ChoixMenu!"=="" ( 
		set ChoixMenu=0
	) else (
		if NOT !ChoixMenu!==!ChoixMenu:q=! (
			set ChoixMenu=0
			Exit
			)
		if NOT !ChoixMenu!==!ChoixMenu:9=! ( 
			set nine=1
			set ChoixMenu=0
			set HasProperValue=0
		) else (
			if NOT !ChoixMenu!==!ChoixMenu:1=! ( 
				set one=1
				set HasProperValue=1
				)
			if NOT !ChoixMenu!==!ChoixMenu:2=! ( 
				set two=1
				set HasProperValue=1
				)
			if NOT !ChoixMenu!==!ChoixMenu:3=! ( 
				set three=1
				set HasProperValue=1
				)
			if NOT !ChoixMenu!==!ChoixMenu:4=! ( 
				set four=1
				set HasProperValue=1
				)
			if NOT !ChoixMenu!==!ChoixMenu:5=! ( 
				set five=1
				set HasProperValue=1
				)
			if NOT !ChoixMenu!==!ChoixMenu:6=! ( 
				set six=1
				set HasProperValue=1
				)
			if NOT !ChoixMenu!==!ChoixMenu:7=! ( 
				set seven=1
				set HasProperValue=1
				)
			if NOT !ChoixMenu!==!ChoixMenu:8=! ( 
				set one=1
				set two=1
				set three=1
				set four=1
				set five=1
				set six=1
				set seven=1
				set ChoixMenu=1234567
				set HasProperValue=1
				)
			)
	)
	if !HasProperValue!==0 ( set ChoixMenu=0 ) 	
)

if !nine!==1 (
	echo:
	echo:
	echo -------------------------- MENU Advanced USers -------------------------------------
	echo: 
	echo  A/ Unhide all win10/telem/upgrade Updates 
	echo  B/ Modify Hosts file to block telemetry
	echo  C/ Enable and start WinUpdates in manual and open panel
	echo  D/ Desactivations variees
	echo  E/ Disable WinUpdates
	echo  R/ Retour au Menu d'origine
	echo  q/ Quitter
	
	echo:
	echo:
	Set /p ChxAdvMenu="Saisir vos choix [A-E] [vous pouvez combiner plusieurs choix. ex: ABC] : "
	
	if "!ChxAdvMenu!"=="" ( 
		set ChxAdvMenu=0
	) else (
		if NOT !ChxAdvMenu!==!ChxAdvMenu:q=! ( 
			set ChxAdvMenu=0
			Exit
			)
		if NOT !ChxAdvMenu!==!ChxAdvMenu:R=! ( 
			set "ChxAdvMenu="
			set "one="
			set "two="
			set "three="
			set "four="
			set "five="
			set "six="
			set "seven="
			set "eight="
			set "nine="
			set "A1="
			set "A2="
			set "A3="
			set "A4="
			set "A5="
			set "ChoixMenu="
			set "HasProperValue="
			set "HasProperValueAgain="
			GOTO Menu_Origin
			)
		if NOT !ChxAdvMenu!==!ChxAdvMenu:A=! ( 
			set A1=1
			set HasProperValueAgain=1
			)
		if NOT !ChxAdvMenu!==!ChxAdvMenu:B=! ( 
			set A2=1
			set HasProperValueAgain=1
			)
		if NOT !ChxAdvMenu!==!ChxAdvMenu:C=! ( 
			set A3=1
			set HasProperValueAgain=1
			)
		if NOT !ChxAdvMenu!==!ChxAdvMenu:D=! ( 
			set A4=1
			set HasProperValueAgain=1
			)
		if NOT !ChxAdvMenu!==!ChxAdvMenu:E=! ( 
			set A5=1
			set HasProperValueAgain=1
			)
	)
	if !HasProperValueAgain!==0 ( set ChxAdvMenu=0 ) 
)
:: fin des menu

if [!arg1!] == [] ( 
	echo No param to begin with so 123456 it is
	set one=1
	set two=1
	set three=1
	set four=1
	set five=1
	set six=1
	set seven=0
	set ChoixMenu=123456
	set HasProperValue=1)

echo:
echo proper val %HasProperValue%
echo %ChoixMenu%
echo !HasProperValueAgain!
echo !ChxAdvMenu!


:: Detection Process - useful ?
echo Detection du type de processeur
echo:

Set processor=FU
REG QUERY "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /f "x86"
if %ERRORLEVEL%==0 ( set processor=x86 ) 

REG QUERY "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /f "x64"
if %ERRORLEVEL%==0 ( set processor=x64 )

:: il y a avait deja un variable predefinie pour ca

:: Installed OS
Set _Bitness=64
IF %PROCESSOR_ARCHITECTURE% == x86 (
  IF NOT DEFINED PROCESSOR_ARCHITEW6432 Set _Bitness=32
  )

echo:
echo ------ Infos System
echo:
echo Operating System : %OS% %_Bitness%bit
ver
echo:
echo type de processeur : %processor% [%PROCESSOR_ARCHITECTURE%]
REM set "SID="
REM echo:
REM wmic useraccount where name="%username%" get sid /value > %~dp0tmp.txt
REM SET /P SID= < %~dp0tmp.txt
REM del %~dp0tmp.txt
REM echo !SID!
REM echo %SID%
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
pause

REM 
::
REM
::       it begins here
REM
::
REM 


if %ChoixMenu% NEQ 0 (

	For /L %%I IN (1,1,3) DO (
		if NOT %ChoixMenu%==!ChoixMenu:%%I=! ( 
		set upupon=1
		set byebyeups=1
		)
	)

	if !upupon! == 1 (
		
		echo:
		echo demarre windows update and co
		echo:
		
		start "" /D "%~dp0Routines\" /wait /HIGH StartWindowsUpdateServices.bat

		echo:
		echo -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-_-__--_-__-
		echo:
		echo:
	)


	if !byebyeups! == 1 (

		if %one% == 1 (
			echo:
			echo Desinstallation de GWX - KB2952664 ...
			wusa /uninstall /kb:2952664 /quiet /norestart
			echo Desinstallation de GWX - KB3035583 ...
			wusa /uninstall /kb:3035583 /quiet /norestart
		
			:: not completly sure about this
			echo:
			echo Desinstallation de KB3012973
			wusa /uninstall /kb:3012973 /norestart /quiet
			
			start "" /D "%~dp0Routines\" /wait /HIGH Riddof_GWX_FileNReg.bat

		)

		if %three% == 1 (
			echo:
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
			
			start "" /D "%~dp0Routines\" /wait /HIGH Config_NoTelemetry.bat
		)

	:: Upgrading
		if %two%==1 (
	:: Update that enables you to upgrade from Windows 7 to a later version of Windows
			echo:
			echo Desinstallation de KB2990214 - Enables upgrade from Windows 7 to a later version of Windows _donc a reactiver pr passer a 8.1_ ...
			wusa /uninstall /kb:2990214 /quiet /norestart
			echo Desinstallation de KB3112343 - passage de win 7 vers win 10
			wusa /uninstall /kb:3112343 /quiet /norestart
			

	:: pour passage 8.1 vers 10
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
			
			
			start "" /D "%~dp0Routines\" /wait /HIGH NoUpgrade.bat
		)
	)
	echo:



	if %four%==1 (
			echo:
			echo lancement de %~dp0Routines\ConfigUpdatesPolicies.bat
			start "" /D "%~dp0Routines\" /wait /HIGH ConfigUpdatesPolicies.bat
			)

	if %five%==1 (
			echo:
			echo lancement de %~dp0Routines\TweakOS.bat
			start "" /D "%~dp0Routines\" /wait /HIGH TweakOS.bat
			)

	if %six%==1 (
			echo:
			echo lancement de %~dp0Routines\CleaningJob.bat
			start "" /D "%~dp0Routines\" /wait /HIGH CleaningJob.bat
			)
			


	if !byebyeups! == 1 (
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
		
		set "list_of_updates="
		
		if EXIST "%~dp0Routines\HideGWXetc.vbs" (
			if %three%==1 (
				set "list_of_updates=%list_of_updates% KB3021917 KB3022345 KB3068708 KB3075249 KB3080149"
			)
			if %two%==1 (		
				set "list_of_updates=!list_of_updates! KB2990214 KB2976978 KB3044374 KB3046480 KB3112343 KB3112336"
			)
			if %One%==1 (
				set "list_of_updates=!list_of_updates! KB2952664 KB3035583 KB3012973"
			)
			echo Masquage des mises a jour !list_of_updates!
			start /b /wait cscript.exe "%~dp0Routines\HideGWXetc.vbs"!list_of_updates!
			
		) else ( 
			echo Le fichier HideGWXetc n'a pas ete trouve.
			echo Celui-ci est necessaire pour masquer les mises a jour.
			echo Veuillez le mettre dans dossier \Routines puis relancer le programme.
		)

	:: ici le wait fonctionne bien. penser amettre le b avant et pas apres
		echo:
		echo Blocker l'execution des scripts
		REG ADD "HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings" /v "Enabled" /t REG_DWORD /d 00000000 /f
		assoc .vbs=blabla
	)
	if %seven%==1 (
		echo:
		echo lancement de %~dp0Routines\Enable-DisableWinUpdate.bat disabler
		start "" /D "%~dp0Routines\" /wait /HIGH Enable-DisableWinUpdate.bat d
		)	
)
:: la c'est la fin du SI ChoixMenu PAS EGAL a ZERO qui est au debut

if %ChxAdvMenu% NEQ 0 (
	echo %errorlevel%

	if %A1%==1 (
		echo:
		echo lancement de %~dp0Routines\EnableWinUpdate.bat
		start "" /D "%~dp0Routines\" /wait /HIGH EnableWinUpdate.bat
			
		echo:
		echo lancement de %~dp0Routines\StartWindowsUpdateServices.bat
			
		echo:
		echo ---------------  unHide ALL win10 / telemetry / upgrade updates   --------------
		echo:
		echo Permettre temporairement l'execution des scripts
	:: retablie l'association de vbs avec script host car si associ‚ avec notepadplusplus par exple, alors ca marche pas
		assoc .vbs=VBSFile
		REG ADD "HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings" /v "Enabled" /t REG_DWORD /d 00000001 /f
		echo:
		echo lancement de %~dp0Routines\ShowGWXetc.vbs
		start /b /wait cscript.exe "%~dp0Routines\ShowGWXetc.vbs" KB3021917 KB3022345 KB3068708 KB3075249 KB3080149 KB2990214 KB2976978 KB3044374 KB3046480 KB2952664 KB3035583 KB3012973 KB3112343 KB3112336
			
		)

	if %A2%==1 (
		echo:
		echo lancement de %~dp0Routines\ModifyHosts_Telemetry.bat
		start "" /D "%~dp0Routines\" /wait /HIGH ModifyHosts_Telemetry.bat
		)

	if %A3%==1 (
		echo:
		echo lancement de %~dp0Routines\Enable-DisableWinUpdate.bat enabler
		start "" /D "%~dp0Routines\" /wait /HIGH Enable-DisableWinUpdate.bat e
	)

	if %A4%==1 (
		echo:
		echo lancement de %~dp0Routines\DesactivShit.bat
		start "" /D "%~dp0Routines\" /wait /HIGH DesactivShit.bat
	)

	if %A5%==1 (
		echo:
		echo lancement de %~dp0Routines\Enable-DisableWinUpdate.bat disabler
		start "" /D "%~dp0Routines\" /wait /HIGH Enable-DisableWinUpdate.bat d
	)

)

if !ChoixMenu! == 0 (
	if !ChxAdvMenu! == 0 ( 
		echo You Didn't choose anything so we'll have to part ways now.
		echo Bye.	
	)
)


echo:
echo -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-_-__--_-__-
echo:
echo                               THE END
echo:
echo -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-__-_-_-_-_-_-_-_-_-__--_-__-
echo:
pause
