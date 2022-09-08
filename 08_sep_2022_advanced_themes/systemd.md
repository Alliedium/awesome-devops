Prerequisites:

1. We need a python script in simple-https directory:
```
[tatyana@rocky ~]$ cd simple-https/
[tatyana@rocky simple-https]$ ls
simple-server.py
[tatyana@rocky simple-https]$ nano simple-server.py
```
The script code is below:
```
import http.server, ssl

server_address = ('0.0.0.0', 4443)
httpd = http.server.HTTPServer(server_address, http.server.SimpleHTTPRequestHandler)
httpd.socket = ssl.wrap_socket(httpd.socket,
                               server_side=True,
                               ssl_version=ssl.PROTOCOL_TLS)
                               httpd.serve_forever()
```

2. We need python to be installed:
```
[tatyana@rocky ~]$ sudo dnf install python3
```
3. We can check if our python script can be executed without errors:
```
[tatyana@rocky simple-https]$ python3 simple-server.py
```
4. In order to start it from the service we need following:
```
[tatyana@rocky ~]$ cd /etc/systemd/system/
[tatyana@rocky system]$ sudo nano simple-https.service
```
The service code is below:
```
[Unit]
Description=Simple HTTPS Server
[Service]
User=tatyana
WorkingDirectory=/home/tatyana/
Type=simple
ExecStart=/usr/bin/python3 /home/tatyana/simple-https/simple-server.py
[Install]
WantedBy=multi-user.target
```
Once you added a new service or made any changes in existing one you should run:
```
[tatyana@rocky system]$ sudo systemctl daemon-reload
```
Then we can start the service:
```
[tatyana@rocky system]$ sudo systemctl start simple-https.service
```
And check our server response:
```
[tatyana@rocky system]$ curl https://10.115.176.36:4443 --insecure
```
Let's stop the service:
```
[tatyana@rocky system]$ sudo systemctl stop simple-https.service
```
Let's make sure the server has been stopped as well 
(make sure it is not still running outside of the server from step 3):
```
[tatyana@rocky system]$ curl https://10.115.176.36:4443 --insecure
```
Check logs:
```
[tatyana@rocky system]$ sudo journalctl -u simple-https.service
```