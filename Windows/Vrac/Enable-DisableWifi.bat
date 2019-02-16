pushd "%~dp0"

Set /p statutwifi="Type "y" to activate YourWIFI and "n" to deactivate it (y/n) :"
echo:
if %statutwifi% == y (

netsh interface set interface name="Wireless" admin=enabled

sc config "Wlansvc" start= auto
net start Wlansvc

) else (

netsh interface set interface name="Wireless" admin=disabled

net stop Wlansvc
sc config "Wlansvc" start= disabled

)


pause