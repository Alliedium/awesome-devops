##  Why and how to use Trim/Discard ## 

LVM normally allocates blocks when a volume is created. 
LVM thin pools instead allocates blocks when they are written. 
This behaviour is called thin-provisioning, because volumes can be much larger than physically available space.

It is good practice running _fstrim_ (discard) regularly on VMs and containers. 
This releases data blocks that the filesystem isn’t using anymore. 
It reduces data usage and resource load. 
Most modern operating systems issue such discard commands to their disks regularly. 
It's only necessary to ensure that the Virtual Machines enable the disk discard option.

In the example [Proxmox](https://pve.proxmox.com/pve-docs/chapter-pve-installation.html) is used as hypervisor. According to the [official documentation](https://pve.proxmox.com/wiki/Qemu/KVM_Virtual_Machines#qm_virtual_machines_settings),`Discard` and `SSD Emulation` flags for drive have to be enabled.
- To enable discard check the according checkbox:
  - The setting is here when creating a VM:
    - ![Discard setting position on VM creation](../images/discard_on_creation.png)
  - The setting is here when editing:
    - ![Discard setting position on VM edit](../images/edit_discard.png)
- The SSD emulation is enabled by default at VirtIO Block devices. If other type is used (e.g., SCSI) it's necessary to enable it explicitly as shown below:
  - ![SSD emulation setting position on VM creation](../images/ssd_emulation.png)
- Regularly run `fstrim` inside guest OS (doesn't matter whether hdd or ssd is used on the host machine)

### Setting up fstrim ###

Check if fstrim.timer is enabled:
```
[user@rocky]$ sudo systemctl status fstrim.timer
● fstrim.timer - Discard unused blocks once a week
Loaded: loaded (/usr/lib/systemd/system/fstrim.timer; disabled; vendor preset: disabled)
Active: inactive (dead)
Trigger: n/a
Docs: man:fstrim
```
Enable & start fstrim.timer:
```
[user@rocky]$ sudo systemctl enable --now fstrim.timer
```

Make sure it got started now:
```
[user@rocky]$ sudo systemctl status fstrim.timer
● fstrim.timer - Discard unused blocks once a week
Loaded: loaded (/usr/lib/systemd/system/fstrim.timer; disabled; vendor preset: disabled)
Active: active (waiting) since Thu 2022-09-08 03:26:48 EEST; 4s ago
Trigger: Mon 2022-09-12 00:35:31 EEST; 3 days left
Docs: man:fstrim

Sep 08 03:26:48 rocky systemd[1]: Started Discard unused blocks once a week.
```
Review the current _fstrim.timer_ settings with `cat /lib/systemd/system/fstrim.timer`.
Edit _fstrim.timer_ settings (if necessary) with the available text editor.
If any changes were made, restart _fstrim.timer_ to apply new settings:
```
[user@rocky]$ sudo systemctl restart fstrim.timer
```
