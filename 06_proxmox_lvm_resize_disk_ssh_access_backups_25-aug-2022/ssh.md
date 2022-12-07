## SSH access setup ##

### Using ssh agent: ###

Check actual state of sshd:
```
sudo systemctl status sshd
```

Generate ssh keys
```
ssh-keygen
```

Send public key to the machine we want to access:
```
ssh-copy-id -i <path> <user>@<ip>
```

Enter with password:
```
ssh -i <path> <user>@<ip>
```

Run agent:
```
eval `ssh-agent`
```

Add user identity:
```
ssh-add <path>
```

Access the machine:
```
ssh <ip>
```

Exit the VM
```
exit
```
### Using alias from config file: ###

Add entry to config file:
```
nano ~/.ssh/config
```
as following:
```
Host <alias>
HostName <ip of the machine we are going to access>
User <user>
IdentityFile <path>
```
Save the changes.

Check you can access the VM:
```
ssh <alias>
```