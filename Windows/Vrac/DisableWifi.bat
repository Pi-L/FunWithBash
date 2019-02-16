netsh interface set interface name="Wireless" admin=disabled

net stop Wlansvc
sc config "Wlansvc" start= disabled

