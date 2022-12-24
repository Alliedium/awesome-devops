## Kubernetes, Setting up K3s prod-like: OPNsense template configuration, part 1, 10 Nov 2022 ##

### 1. In Proxmox [create pool k3s-simple1, install SDN and setup VLAN 10](../23_networks_vlan_nested_proxmox_cloud-init_27-oct-2022/README.md), as in the following steps: 9 - Create resource pool, 6 - Install SDN, 10 - Create VLAN20 in SDN (in our case create VLAN 10).

### 2. In Proxmox create ***<font color="green">OPNsense</font>*** VM, start it, set the single network interface as WAN, login as `installer` and continue installation. After installation login as root and update ***<font color="green">OPNsense</font>*** packets.
   
`OPNsense -> System -> Updates`

- Install plugins `os-nginx` and `os-qemu-guest-agent`.

    `OPNsense -> System -> Plugins`

- Add rule for WAN in Firewall for ensure web GUI access

    `OPNsense -> Firewall -> Rules -> WAN`

![Regenerate image](./images/gui_rule.jpg)

- Turn ***<font color="green">OPNsense</font>*** off, Right click on ***<font color="green">OPNsense</font>*** VM and create template `opnsense-template`. 

![Regenerate image](./images/create_template1.jpg)

## References ##

1. [Lesson_22 How to set up VLANs](../22_networks_vlan_opnsense_vms_25-oct-2022/practice.md)
2. [Lesson_23 How to set up VLANs](../23_networks_vlan_nested_proxmox_cloud-init_27-oct-2022/practice.md)





