## Using fstrim, Cloud-Init, Ansible, LVM resize additional PV ##

| Example | Details |
|------|-------|
| [Instruction 1](./fstrim_timer.md) | fstrim setup and usage |
| [Instruction 2](./cloudinit.md) | Generating VMs from cloud-init images |
| [Instruction 3](./ansible.md) | Configuring VMs using Ansible |
| [Instruction 4](./lvm_resize_additional_pv.md) | How to resize LVM with additional PV |
| [Instruction 5](./systemctl.md) | Managing a simple HTTPS server with systemctl |

### References ###

1. [Хабр Q&A: Нужно ли в виртуалках создавать LVM, если я захочу увеличить объем диска?](https://qna.habr.com/q/671189)
2. [How to resize a logical volume with 5 simple LVM commands](https://www.redhat.com/sysadmin/resize-lvm-simple)
3. [Proxmox with LVM-thin and why we should use Trim/Discard](https://gist.github.com/hostberg/86bfaa81e50cc0666f1745e1897c0a56)
4. [Proxmox VE Administration Guide](https://pve.proxmox.com/pve-docs/pve-admin-guide.html)
5. [Solid state drive (more about trim here)](https://wiki.archlinux.org/title/Solid_state_drive)
6. [Object vs. File vs. Block Storage: What’s the Difference?](https://www.ibm.com/cloud/blog/object-vs-file-vs-block-storage)
7. [List of file systems](https://en.wikipedia.org/wiki/List_of_file_systems)
8. [Why Systemd is the Devil but I Love It](https://www.youtube.com/watch?v=hc7J-zWEty8)
9. [Writing Init Scripts on Alpine Linux](https://wiki.alpinelinux.org/wiki/Writing_Init_Scripts)
10. [Working with OpenRC](https://docs.alpinelinux.org/user-handbook/0.1a/Working/openrc.html)
11. [SSH handshake explained](https://goteleport.com/blog/ssh-handshake-explained/)
12. [Diffie Hellman key exchange](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange)
13. [Man-in-the-middle attack in SSH - How does it work?](https://www.ssh.com/academy/attack/man-in-the-middle#various-ways-to-prevent-the-attack)
14. [Understanding the SSH Encryption and Connection Process](https://www.digitalocean.com/community/tutorials/understanding-the-ssh-encryption-and-connection-process)
15. [Cloud-Init Support in Proxmox](https://pve.proxmox.com/wiki/Cloud-Init_Support)
16. [Ansible Galaxy site](https://galaxy.ansible.com/)
17. [Terraform provider plugin for Proxmox](https://github.com/Telmate/terraform-provider-proxmox)