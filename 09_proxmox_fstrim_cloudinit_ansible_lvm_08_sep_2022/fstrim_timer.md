###  Why and how we should use Trim/Discard ### 

LVM normally allocates blocks when you create a volume. 
LVM thin pools instead allocates blocks when they are written. 
This behaviour is called thin-provisioning, because volumes can be much larger than physically available space.

It is good practice to run _fstrim_ (discard) regularly on VMs and containers. 
This releases data blocks that the filesystem isn’t using anymore. 
It reduces data usage and resource load. 
Most modern operating systems issue such discard commands to their disks regularly. 
You only need to ensure that the Virtual Machines enable the disk discard option.

According to official documentation, we need
-   Enable `Discard` and `SSD Emulation` flags for drive
-   Regularly run `fstrim` inside guest OS (doesn't matter hdd or ssd used on the host machine)

### Check if fstrim.timer enabled ###
```
[tatyana@rocky system]$ sudo systemctl status fstrim.timer
● fstrim.timer - Discard unused blocks once a week
Loaded: loaded (/usr/lib/systemd/system/fstrim.timer; disabled; vendor preset: disabled)
Active: inactive (dead)
Trigger: n/a
Docs: man:fstrim
[tatyana@rocky system]$ sudo systemctl start fstrim.timer
[tatyana@rocky system]$ sudo systemctl status fstrim.timer
● fstrim.timer - Discard unused blocks once a week
Loaded: loaded (/usr/lib/systemd/system/fstrim.timer; disabled; vendor preset: disabled)
Active: active (waiting) since Thu 2022-09-08 03:26:48 EEST; 4s ago
Trigger: Mon 2022-09-12 00:35:31 EEST; 3 days left
Docs: man:fstrim

Sep 08 03:26:48 rocky systemd[1]: Started Discard unused blocks once a week.
[tatyana@rocky system]$ sudo nano /lib/systemd/system/fstrim.timer
```