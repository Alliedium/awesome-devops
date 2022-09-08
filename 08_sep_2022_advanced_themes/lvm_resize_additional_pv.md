Демо на resize a logical volume on LVM with an additional pv

### How to resize a logical volume with 5 simple LVM commands ###

Have you ever wondered how to extend your root or home directory file system partition using LVM? 
You might have low storage space and you need to increase the capacity of your partitions. 
This example looks at how to extend storage in Linux using Logical Volume Manager (LVM).

### Process summary ###

The process is straightforward. 
1. Attach the new storage to the system. 
2. Create a new Physical Volume (PV) from that storage. 
3. Add the PV to the Volume Group (VG) 
4. Extend the Logical Volume (LV).

The xdb disk is the new disk attached to it. 
Extend the root partition to make it 11G in size (initially 9 in our example).

lsblk command displays volume sizes

### Create a Physical Volume ###

pvcreate command to create a new physical volume
Use the pvcreate command to designate a disk as a PV.

```
sudo pvcreate /dev/xdb
```
Physical volume "/dev/xdb" successfully created.

When you attach the new storage /dev/xdb, you need to use the pvcreate command in order for the disk to be initialized and be seen by the Logical Volume Manager (LVM).

### Identify the Volume Group ###

Next, you need to identify the Volume Group (VG) to which you are extending the new disk with the vgs command. 
Mine is called centos, and that's the only VG available currently on my LVM.
```
sudo vgs
```
vgs command displays volume group information

### Extend the Volume Group ###

The vgextend command allows you to add one or more initialized Physical Volumes to an existing VG to extend its size.

As you can see, you want to extend the rl Volume Group.

The vgextend command adds capacity to the VG.
```
sudo vgextend rl /dev/xdb
```
After extending it, type the vgs or vgdisplay commands for a more detailed overview of the VG.
```
sudo vgs
```
vgs command displays volume group information
```
sudo vgdisplay
```
The vgdisplay shows all the VGs in the LVM and displays the complete information about them.


As you can see from the image above, marked with red, you have 2GB free. You can decide to extend all or some amount of storage size to it.

### Identify the Logical Volume ###

The lvs or lvdisplay command shows the Logical Volume associated with a Volume Group. Use the lvs command, and the Logical Volume you're trying to extend is the root, which belongs to the centos VG. As you can see above, you've already extended the VG. Next, extend the Logical Volume.
```
sudo lvs
```
lvs command displays logical volume information

### Extend the Logical Volume ###

Extend the LV with the lvextend command. The lvextend command allows you to extend the size of the Logical Volume from the Volume Group.

lvextend command displays logical volume information
```
sudo lvextend -l +100%FREE /dev/rl/root
```

### Extend the filesystem ###

You need to confirm the file system type you're using, Red Hat uses the XFS file system, but you can check the file system with lsblk -f or df -Th.

Resize the filesystem on the Logical Volume after it has been extended to show the changes. Resize the XFS filesystem by using the xfs_growfs command.
lvextend command displays logical volume information
```
sudo xfs_growfs /dev/rl/root
```
Use the xfs_growfs command to grow the filesystem on the newly extended LV.

Finally, verify the size of your extended partition.
```
df -h
```
Use the df -h command to display storage information.

### Wrap up ###

You can extend any other partition with the steps shown. 
You just have to ensure you're using LVM and know the partition you're extending.

