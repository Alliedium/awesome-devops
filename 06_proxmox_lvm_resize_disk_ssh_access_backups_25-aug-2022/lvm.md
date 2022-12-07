## Disk resize ##

### Prerequisites: ###

- VM with Rocky Linux
- Root partition should be the last by order (though there is possibility to resize independent on partition order, this example does it for the simple case).
- Discard checkbox should be checked (for fstrim usage).

### Resize LVM Thin Pool: ###

lsblk lists information about all available or the specified block devices. The command prints all block devices (except RAM disks) in a tree-like format by default.
```
lsblk
```
Resize disk in Proxmox UI: Hard Disk > Disk Action > Resize.

Install the growpart utility:
```
sudo dnf install cloud-utils-growpart
```
Check info in the partitions table:
```
sudo fdisk -l
```
Check block devices details:
```
lsblk
```
Resize partition:
```
sudo growpart /dev/vda 2
```
```
sudo fdisk -l
```
```
lsblk
```
```
sudo lvs
```
```
df -hT
```
```
sudo pvs
```
Resize physical volume:
```
sudo pvresize /dev/vda2
```
```
sudo pvs
```
```
sudo vgs
```
```
sudo lvdisplay
```
Resize pool:
```
sudo lvextend -l +100%FREE /dev/wrl/pool00
```
```
sudo lvs -a
```
Resize root:
```
sudo lvextend -L 13.96g /dev/wrl/root
```
Resize file system:
```
sudo resize2fs /dev/wrl/root
```
Go to the node's shell & check VM size and data percentage:
```
lvs -a
lvs -a | grep vm-<id>-disk
```
Go back into VM and run command to create a file which would consume 2G:
```
dd if=/dev/urandom of=image.crypted bs=1M count=2048
```
Check percentage of used has increased in the VM:
```
df -h
```
Check percentage of used has increased on the node level:
```
lvs -a | grep vm-<id>-disk
```
Go back into VM and run command to remove the file:
```
rm image.crypted
```
Check percentage of used has decreased in the VM:
```
df -h
```
Check percentage of used is the same on the node level:
```
lvs -a | grep vm-<id>-disk
```
Go back to VM console and run command to discard blocks which are not used by filesystem:
```
sudo fstrim -a -v
```
Check percentage of used has decreased on the node level:
```
lvs -a | grep vm-<id>-disk
```
### Resize standard partition (no LVM) ###
Prerequisites: root partition should be the last by order.

Check actual state:
```
df -hT
```
Resize disk in Proxmox UI: Hard Disk > Disk Action > Resize
```
df -hT
```
Resize partition:
```
sudo growpart /dev/vda 2
```
```
lsblk
```
Resize file system:
```
sudo resize2fs /dev/vda2
```
