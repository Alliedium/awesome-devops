## Practice --- SSL termination with self-signed certificate
	
1. Clone source files

```
git clone https://github.com/Alliedium/devops-course-2022.git
```

2. Go to `~/devops-course-2022/29_sep_2022_network_certificate_part_3/simple-https`
	
3. Run http server on Rocky linux.

```
python3 simple-server-http.py
```

Run http server on Manjaro linux.

```
python simple-server-http.py
```

4. In a browser on a host on the same subnet as the http-server, enter the address

`http://<ip_address_http_server>:8081`
 
5. Allow access to opnSense WEB GUI from  WAN network interface.

6. Update OpnSense.

7. Intsall `os-nginx` plugin in OpnSense.

8. Make port forwarding from 4822 port to VM1 'Rocky' virtual machine (http server) IP address on port 22 for ssh connection. 
In you local machine terminal run the command

```
ssh user@<wan_opnsense_ip_address> -p 4822
```

9. Make port forwarding from 8081 port to VM1 'Rocky' virtual machine (http server) IP address on port 8081.
 
10. Check http server, on your home machine in a browser enter the address

`http://<wan_opnsense_ip_address>:8081`
	
11. In OpnSense add the new internal Certificate Authority

10. Add new self-signed SSL certificate.

11. In OpnSense, nginx plugin, set up 
 - `Upstream Server`
 - `Upstream` (Group of Upstream Servers)
 - `Location`
 - `HTTP Server`.

12. Open access in OpnSense for WAN on port `8443 (HTTPS Listener port)` 

13. Check https server (TLS termination), on your home machine in a browser enter the address

`http://<wan_opnsense_ip_address>:8443`

14. Check self-signed sertificate.
