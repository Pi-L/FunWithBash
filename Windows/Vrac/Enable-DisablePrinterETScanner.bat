echo off
pushd "%~dp0"
cls

Set /p statutWU="E to Enable, D to Disable PinterEtScanner (e/d) :"
echo

if %statutWU% == e (

sc config "Spooler"  start= demand
net start Spooler

sc config "StiSvc"  start= demand
net start StiSvc


)

if %statutWU% == E (

sc config "Spooler"  start= demand
net start Spooler

sc config "StiSvc"  start= demand
net start StiSvc


) 


if %statutWU% == d (

sc config "StiSvc" start= disabled
net stop StiSvc

sc config "Spooler"  start= disabled
net stop Spooler

)


if %statutWU% == D (

sc config "StiSvc" start= disabled
net stop StiSvc

sc config "Spooler"  start= disabled
net stop Spooler


)
