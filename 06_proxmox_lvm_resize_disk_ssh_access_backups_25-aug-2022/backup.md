##  Backup Common Storage ##

### Prerequisites: ###

Add 2 hard disks 20G VirtIO Block each to the cluster which needs to be set for backups.

### Steps: ###

Run lsblk in the node's shell to check the names the disks got.
```
lsblk
```

Create pool:
```
zpool create bpool mirror vdb vdc
```
```
lsblk
```
```
zfs list
```

Create dataset:
```
zfs create bpool/backups
```

Set quota:
```
zfs set quota=20G bpool
```

Check quota:
```
zfs get quota bpool
```

Set compression:
```
zfs set compression=zstd bpool
```

Check compression:
```
zfs get compression bpool
```

Create user:
```
useradd backup_user
```
```
passwd backup_user
```

Check ZFS properties:
```
zfs list
```

Set user as backups folder owner
```
cd /bpool/
```
```
chown -R backup_user:backup_user ./backups
```
```
cd ..
```

Install samba:
```
apt install samba
```

Make user samba user:
```
smbpasswd -a backup_user
```

Open samba config file:
```
nano /etc/samba/smb.conf
```

Edit samba config by adding following section to it:
```
server role = standalone server
create mask = 0777
directory mask= 0777
[share]
comment = root share
browseable = yes
path = /storage/share
guest ok = no
read only = no
```

Test the config file:
```
testparm
```

Restart service:
```
systemctl restart smbd
```

Check service status:
```
systemctl status smbd
```

Save the IP address for further setting in UI:
```
ip a
```
