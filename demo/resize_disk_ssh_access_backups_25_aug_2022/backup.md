Демо на Backup Setup

### Backup Common Storage ###
Add 2 hard discs 20G Virtio Block each to the cluster which needs to be set for backups.

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
```
zfs get quota bpool
```
Set compression:
```
zfs set compression=zstd bpool
```
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
Make user samba user:
```
apt install samba
```
```
smbpasswd -a backup_user
```
Edit samba config by adding following section to it:
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
nano /etc/samba/smb.conf
```
Test the config file:
```
testparm
```
Restart service:
```
systemctl restart smbd
```
```
systemctl status smbd
```
Save ip for further setting in UI:
```
ip a
```
