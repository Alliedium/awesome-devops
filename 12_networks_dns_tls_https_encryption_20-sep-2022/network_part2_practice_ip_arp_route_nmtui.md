## Network Practices part I
		
Check if install servise  NetworkManager
	
```
systemctl status NetworkManager
```
	
This srvice manages networks and responsible for completing the file `/etc/resolv.conf`
	
```
cat /etc/resolv.conf
```
	
The entry in this file points to DNS, it is also responsible for network interface settings.
Let's see ip

```	
ip a
```
	
NetworkManager service has a graphical interface.
	
```
nmtui
```
	
And here everything is intuitively clear. If you change the DNS, you will see the changes in the `/etc/resolv.conf` file.
But there is also a terminal client of this tool.
	
```
nmcli
```
	
`nmcli` is similar to `ip a`, but in the first case there is a default gateway.
	
Using nmcli it is convenient to set a static IP
	
```
nmcli con
```

Using this command we can see all active connections. And with this utility you can turn connections off and on as you do in the graphical interface.
If you change the network connection parameters, you need to reboot the adapter. Changes are not automatically applied.
Changing network settings
	
```
sudo nmcli con mod ens18 ipv4.method manual ipv4.addresses 10.1.8.20/24 gw4 10.1.8.3 ipv4.dns "10.1.8.3"
```

`ens18` should be replaced with the connection name, which you can get from `nmcli con`
	
Turn off and on the network adapter
	
```
nmcli con down ens18;nmcli con up ens18;
```

`ens18` is the name from output `nmcli con`

```	
nmcli --help
```
	
Installing `net-tools`
	
```
sudo pacman -S net-tools	
```
	
Look at the arp table
	
```
arp
```
	
Look at the route table
	
```
ip route
```
