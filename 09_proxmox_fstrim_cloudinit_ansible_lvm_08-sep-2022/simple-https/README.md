## Simple HTTPS server creation and management with systemctl ##

### Prerequisites ###

The following commands were executed on VM with [Rocky 8 Linux distribution](https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.7-x86_64-minimal.iso) (however, almost the same commands might be performed on a machine with other Linux distribution OS).
See the general instructions on VM creation & OS installation in [Lesson 1](../01_devops_introductory_virtualization_09-aug-2022/README.md).


1. Python should to be installed:
```
sudo dnf install python3
```

2. There should be 3 files in simple-https directory:
```
cd $HOME/awesome-devops/simple-https
```
```
ls
```
Result:
```
example-com.conf  make-cert.sh  simple-server.py
```

### Creation ###

1. Run make-cert.sh first in order to generate certificate.
```
./make-cert.sh
```

2. Check if the python script can be executed without errors:
```
python3 simple-server.py
```
 
3. In order to start it from the service it's necessary to create it:
```
sudo cat <<EOF > /etc/systemd/system/simple-https.service
[Unit]
Description=Simple HTTPS Server
[Service]
User=$USER
WorkingDirectory=$HOME
Type=simple
ExecStart=/usr/bin/python3 $HOME/simple-https/simple-server.py
[Install]
WantedBy=multi-user.target
EOF
```

4. Once a new service is added reload the systemctl daemon:
```
sudo systemctl daemon-reload
```

### Management ###

Start the service:
```
sudo systemctl start simple-https.service
```

Check server's response:
```
curl https://10.115.176.36:4443 --insecure
```

Stop the service:
```
sudo systemctl stop simple-https.service
```

Check server's response to make sure the server has been stopped (not still running outside the server):
```
curl https://10.115.176.36:4443 --insecure
```

View logs:
```
sudo journalctl -u simple-https.service
```