Prerequisites:

1. We need 3 files in simple-https directory (you can find them in simple-https directory and pass via scp onto your VM):
```
[tatyana@rocky ~]$ cd simple-https/
[tatyana@prodlike-config simple-https]$ ls
example-com.conf  make-cert.sh  simple-server.py
[tatyana@rocky simple-https]$ nano simple-server.py
```

2. We need python to be installed:
```
[tatyana@rocky ~]$ sudo dnf install python3
```
3. We should run make-cert.sh first in order to generate certificate.

4. We can check if our python script can be executed without errors:
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
(make sure it is not still running outside the server from step 3):
```
[tatyana@rocky system]$ curl https://10.115.176.36:4443 --insecure
```
Check logs:
```
[tatyana@rocky system]$ sudo journalctl -u simple-https.service
```