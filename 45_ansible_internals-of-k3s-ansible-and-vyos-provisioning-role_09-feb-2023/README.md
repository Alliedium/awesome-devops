# Explain `Vyos` Ansible playbook

### In our [39 lesson](../39_setting_up_production_like_kubernetes_cluster_part_4_14_dec_2022#create-vyos-vm-on-proxmox-node-via-ansible-playbook) we have shown as run `Vyos` `Ansible` playbook.

In this tutorial we explained how [Vyos `Ansible` playbook](https://github.com/Alliedium/awesome-proxmox/tree/main/vyos-proxmox-kvm#create-vyos-vms-on-proxmox-node-via-ansible-playbooks) works. 

  * Before you start playbook see [System requirements](https://github.com/Alliedium/awesome-proxmox/tree/main/vyos-proxmox-kvm#prerequisites) section.
  * How to install latest `Ansible` version on `Debian` or `Ubuntu` see [Install the latest version of Ansible](https://github.com/Alliedium/awesome-ansible#setting-up-config-machine) section.

  * `Inventary` was discussed in [33 lesson](../33_ansible_basic-concepts-simple-examples-part-1_24-nov-2022#ansible-basic-concepts-and-simple-examples-part-1).
  * `Ansible` vars precedence was explained in [36 lesson](../36_ansible_basic-concepts-simple-examples-part-3_06-dec-2022/README.md).
  * `VIP` and `metallb` - [40 lesson](../40_setting_up_production_like_kubernetes_cluster_part_5_15_dec_2022#7-show-how-metallb-loadbalancer-work).
  * `ssh-keygen` - [6](../06_proxmox_lvm_resize_disk_ssh_access_backups_25-aug-2022#using-ssh-agent) and [29 lessons](../29_kubernetes_setting_up_k3s_prod_like_configuring_opnsense_creating_k3s_nodes_part_2-10_nov_2022#3-on-your-workstation-in-terminal-generate-ssh-keys).
  * `Systemd` - [9 lesson](../09_proxmox_fstrim_cloudinit_ansible_lvm_08-sep-2022/README.md).

# References on #

1. [kubectl wait](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#wait)
2. [The pkill Command in Linux](https://linuxhint.com/the-pkill-command-in-linux/)
3. [set -e, -u, -x, -o pipefail](https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425)
4. [Install Vyos](https://docs.vyos.io/en/latest/installation/install.html)
5. [VyOS cloud-init](https://docs.vyos.io/en/latest/automation/cloud-init.html)
6. [Network Address Translation ( NAT Types )](https://utechnoworld.com/network-address-translation-nat-types/)
7. [Netmask](https://jodies.de/ipcalc)
8. [proxmox_kvm module](https://docs.ansible.com/ansible/2.9/modules/proxmox_kvm_module.html)
9. [Understanding File Permissions](https://www.multacom.com/faq/password_protection/file_permissions.htm)