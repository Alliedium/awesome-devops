## How to set up VLANs with SDN in nested Proxmox ##

### Prerequisites: ###
- [Proxmox node](https://www.proxmox.com/en/proxmox-ve/get-started) with ~ 16 GiB RAM and ~ 90 GB local disk storage
- Completed steps from [Lesson 22](../22_networks_vlan_opnsense_vms_25-oct-2022/README.md)
- Proxmox ISO installed via [Proxmox ISO installer](https://www.proxmox.com/en/downloads/item/proxmox-ve-7-3-iso-installer)

The ISO images should be uploaded in the local storage on Proxmox:
- ![local storage](./images/local_storage.png)

### Steps: ###

#### 6. Prepare Proxmox template
* Create a VM with Proxmox ISO (Note: When creating VM on tab CPU: Type = host)
  - ![Type host](./images/type_host.png)
* Start VM
* Disable the repository by commenting out the above line using a # (at the start of the line). This prevents error messages if you do not have a subscription key.
```
sed "s/deb https:\/\/enterprise.proxmox.com\/debian\/pve bullseye pve-enterprise/#deb https:\/\/enterprise.proxmox.com\/debian\/pve bullseye pve-enterprise/" /etc/apt/sources.list.d/pve-enterprise.list
```
* Run `cat /etc/apt/sources.list.d/pve-enterprise.list` in order to make sure that the file now corresponds to the following:
- ![Proxmox_setup_2](./images/pve-enterprise.png)
* Configure the pve-no-subscription repository:
```
echo -e '\ndeb http://download.proxmox.com/debian/pve bullseye pve-no-subscription' >> /etc/apt/sources.list
```
* Run `cat /etc/apt/sources.list` in order to make sure that the file now corresponds to the following:
- ![Proxmox_setup_1](./images/pve-no-subscription.png)
* Install SDN
    - To enable the experimental Software Defined Network (SDN) integration, you need to install the _libpve-network-perl_ and _ifupdown2_ packages on every node:
        
        ```
        apt upgrade
        apt update
        apt install libpve-network-perl ifupdown2
        ```

    - Note: Proxmox VE version 7 and above come installed with _ifupdown2_.
    - After this, you need to add the following line to the end of the `/etc/network/interfaces` configuration file, so that the SDN configuration gets included and activated.
        
        ```
        source /etc/network/interfaces.d/*
        ```

* Install _qemu-guest-agent_:
    
    ```
    apt install qemu-guest-agent
    sudo systemctl enable --now qemu-guest-agent
    systemctl status qemu-guest-agent
    ```

* Set up VLAN3 via update `/etc/network/interfaces` on each Proxmox VM (IP addresses will be different, i.e. .20, .21, .22!)
    
    ```   
    auto lo
    iface lo inet loopback
    
    iface ens18 inet manual
    
    auto vmbr0.3
    iface vmbr0.3 inet static
           address  10.3.0.21/24
           gateway  10.3.0.1
    
    auto vmbr0
    iface vmbr0 inet manual
            bridge-ports ens18
            bridge-stp off
            bridge-fd 0
            bridge-vlan-aware yes
            bridge-vids 2-4094
    ```

#### Note: Instead of range you can mention particular admissible VLANs, i.e. `bridge-vids 3 20 21 22` in our case. ####

* Get cloud-init scripts:

  ```
  apt install git
  git clone --branch 28102022 https://github.com/Alliedium/awesome-proxmox $HOME/awesome-proxmox
  ```

* Send SSH key to be placed `~/.ssh/id_rsa_cloudinit.pub`
* Shutdown the VM
* Convert to template
---------------------------------------------------------------------------
#### 7. Make 3 linked clones from the Proxmox template
* On each clone make the following:
    * Save current hostname in a variable:

    ```
    currenthostname=$(hostname)
    ```

    * Set a new hostname (replace `<new-hostname>` in the command with the value you want to set):

    ```
    hostnamectl set-hostname <new-hostname>
    ```
  
    * Edit hostname and/or IP in the following configuration files:
        - Edit hostname & IP in `/etc/hosts` (replace `<new-IP>` and `<new-hostname>` in the command with the values you want to set):

        ```
        sed -i -r "s/(\b[0-9]{1,3}\.){3}[0-9]{1,3}\b $currenthostname.*/<new-IP> <new-hostname>/" /etc/hosts
        ```

        - Edit hostname in `/etc/postfix/main.cf` (replace `<new-hostname>` in the command with the value you want to set):
    
        ```
        sed -i "s/$currenthostname/<new-hostname>/" /etc/postfix/main.cf
        ```
  
        - Edit IP address & gateway in `/etc/network/interfaces` (replace `<new-gateway>`, `<new-IP>` & `<subnet mask>` in the command with the values you want to set):

        ```
        sed -i -r 's/(\b[0-9]{1,3}\.){3}[1]{1}\b'/"<new-gateway>"/  /etc/network/interfaces
        sed -i -r "s/(\b[0-9]{1,3}\.){3}[0-9]{1,3}\/[0-9]{1,3}\b"/"<new-IP>\/<subnet mask>"/  /etc/network/interfaces
        ```
  
    * Check if `/etc/network/interfaces` has no errors after the update:

    ```
    ifreload -s -a
    ```
  
    * Reload interfaces:

    ```
    ifreload -a
    ```
  
    * Re-generate certificates:

        - Remove the apparently relevant files manually:

        ```
        rm /etc/pve/pve-root-ca.pem /etc/pve/priv/pve-root-ca.key /etc/pve/nodes/*/pve-ssl.{key,pem}
        ```
      
        - Regenerate the certificates and restart _pveproxy_:

        ```
        pvecm updatecerts --force
        systemctl restart pveproxy
        ```
      
* Check connectivity of each node to each node via ping.
---------------------------------------------------------------------------
#### 8. Create cluster

* Open each node in a separate tab in browser on manjaro2
* Select Datacenter on the 1st node UI > \[Create cluster] > \[Copy Join info]
* On 2nd and 3rd node click \[Join cluster], paste the info and enter the password
---------------------------------------------------------------------------
#### 9. Create Ubuntu VMs on 1st node
* Create resource pool via command line:
  
    ```
    pvesh create /pools --poolid ubuntu-pool
    ```

* or via UI:
  - ![Create resource pool](./images/create_pool.png)
* Go to the git directory you've cloned from git:

    ```
    cd $HOME/awesome-proxmox/vm-cloud-init-shell/
    ```

* Follow the [instructions](https://github.com/Alliedium/awesome-proxmox/blob/main/vm-cloud-init-shell/README.md) to copy `.env.example`, edit it (_Pz_VM_TEMPLATE_ID_, _Pz_VM_ID_PREFIX_, _Pz_TARGET_NODE_LIST_) and apply the updated environment settings.
* Run script to download cloud-init image:

    ```
    ./download-cloud-init-images.sh
    ```

* Run script to create Ubuntu cloud-init template on 1st node:

    ```
    ./create-template.sh
    ```

* Run script to create 2 linked clones on 1st node - ubuntu1 & ubuntu2:

    ```
    ./create-vms.sh
    ```

* DO NOT START VMS BEFORE THE SETUP!
---------------------------------------------------------------------------
#### 10. Set up ubuntu1
* Create VLAN20, VLAN21 and VLAN22 in SDN (SDN > Zones > Add > VLAN; SDN > Vnets > Create)
  - ![Create VLAN via SDN](./images/sdn_plugin.png)
* Apply changes: Datacenter > SDN > click \[Apply\]
* Update ubuntu1 settings: Hardware > Network device > Edit > select v20 instead of vmbr0
* Go to Cloud-Init > edit DNS servers & IP Config:
  - 10.20.0.1
  - ip=10.20.0.11/24,gw=10.20.0.1

#### Note 1:

```
Instead of manual editing of DNS, IP & gateway, you can switch your copy of .env.example to use DHCP.
In order to do this uncomment the line:
  Pz_IP_MODE=dhcp
And comment the one below:
  #Pz_IP_MODE=static
```

#### Note 2:

```
It is possible to change the image parameters via Cloud-init tab later, then to regenerate image, and execute hard reboot (stop & start the VM).
User can regenerate image after updating parameters without stopping the VM, but in this case in order to apply the changes it's necessary to run following commands within the VM's shell:
cloud-init clean
cloud-init init
```

- ![Regenerate image](./images/regenerate_image.png)
* Start ubuntu1
* Install _qemu-guest-agent_:
    ```
    sudo apt update
    sudo apt upgrade
    sudo apt install -y qemu-guest-agent
    sudo systemctl enable --now qemu-guest-agent
    ```
* Check the values set in _netplan_ configuration with `cat /etc/netplan/50-cloud-init.yaml` and in case any correction to network configuration (IP address, gateway & nameserver) is necessary, it might be done this way:

#### Note: DO NOT execute the below commands with `-i` flag unless the output of each command executed without it corresponds to your expectations.

```
sed -i -r 's/(\b[0-9]{1,3}\.){3}[1]{1}\b'/"10.20.0.1"/  /etc/netplan/50-cloud-init.yaml
sed -i -r "s/(\b[0-9]{1,3}\.){3}[0-9]{1,3}\/[0-9]{1,3}\b"/"10.20.0.11\/24"/  /etc/netplan/50-cloud-init.yaml
netplan apply
```

* Validate connectivity is as expected via `ping <IP address>` of the following endpoints:
    - VLAN20 gateway
    - OPNsense gateway
    - web
    - manjaro1
    - manjaro2
    - manjaro3
---------------------------------------------------------------------------
#### 11. Set up ubuntu2
* Set up VLAN21 in OPNsense:
    - Interfaces > Other Types > VLAN > \[+\]
    - Interfaces > Assignments > VLAN > \[+\]
    - In interfaces appeared new options, edit
        - enable
        - description
        - static IP
        - IPv4 - set address
    - Service > DHCPv4
    - Firewall > Rules
      - Create a new rule(s) according to your VLAN to VLAN connectivity plan
      - Check 'Log packets that are handled by this rule' checkbox for each new rule
    - Set connectivity VLAN20 : VLAN21
* Update ubuntu2 settings: Hardware > Network device > Edit > select v21 instead of vmbr0
* Go to Cloud-Init > edit DNS servers & IP Config:
  - 10.21.0.1
  - ip=10.21.0.12/24,gw=10.21.0.1
* Start ubuntu2
* Install _qemu-guest-agent_:
    
    ```
    sudo apt update
    sudo apt upgrade
    sudo apt install -y qemu-guest-agent
    sudo systemctl enable --now qemu-guest-agent
    ```

* Check the values set in _netplan_ configuration with `cat /etc/netplan/50-cloud-init.yaml` and in case any correction to network configuration (IP address, gateway & nameserver) is necessary, it might be done this way:
#### Note: DO NOT execute the below commands with `-i` flag unless the output of each command executed without it corresponds to your expectations.
```
sed -i -r 's/(\b[0-9]{1,3}\.){3}[1]{1}\b'/"10.21.0.1"/  /etc/netplan/50-cloud-init.yaml
sed -i -r "s/(\b[0-9]{1,3}\.){3}[0-9]{1,3}\/[0-9]{1,3}\b"/"10.21.0.12\/24"/  /etc/netplan/50-cloud-init.yaml
netplan apply
```
* Validate connectivity is as expected via `ping <IP address>` of the following endpoints:    
    - VLAN20 gateway
    - OPNsense gateway
    - web
    - manjaro1
    - manjaro2
    - manjaro3
    - ubuntu1
---------------------------------------------------------------------------
#### 12.Create Ubuntu VMs on 2nd node
* Go to the git directory you've cloned from git:
```
cd $HOME/awesome-proxmox/vm-cloud-init-shell/
```
* Follow the [instructions](https://github.com/Alliedium/awesome-proxmox/blob/main/vm-cloud-init-shell/README.md) to copy `.env.example`, edit it (_Pz_VM_TEMPLATE_ID_, _Pz_VM_ID_PREFIX_, _Pz_TARGET_NODE_LIST_) and apply the updated environment settings.
* Run script to download cloud-init image on 2nd node: download-cloud-init-images.sh
* Run script to create an Ubuntu cloud-init-generated template on 2nd node: create-template.sh
* Run script to create 2 linked clones on 2nd node - ubuntu3 & ubuntu4: create-vms.sh
* DO NOT START VMS BEFORE SETUP
---------------------------------------------------------------------------
#### 13. Set up ubuntu3
* Update ubuntu3 settings: Hardware > Network device > Edit > select v21 instead of vmbr0
* Go to Cloud-Init > edit DNS servers & IP Config:
  - 10.21.0.1
  - ip=10.21.0.13/24,gw=10.21.0.1
* Start ubuntu3
* Install _qemu-guest-agent_:
    
    ```
    sudo apt update
    sudo apt upgrade
    sudo apt install -y qemu-guest-agent
    sudo systemctl enable --now qemu-guest-agent
    ```

* Check the values set in _netplan_ configuration with `cat /etc/netplan/50-cloud-init.yaml` and in case any correction to network configuration (IP address, gateway & nameserver) is necessary, it might be done this way:
#### Note: DO NOT execute the below commands with `-i` flag unless the output of each command executed without it corresponds to your expectations.
```
sed -i -r 's/(\b[0-9]{1,3}\.){3}[1]{1}\b'/"10.21.0.1"/  /etc/netplan/50-cloud-init.yaml
sed -i -r "s/(\b[0-9]{1,3}\.){3}[0-9]{1,3}\/[0-9]{1,3}\b"/"10.21.0.13\/24"/  /etc/netplan/50-cloud-init.yaml
netplan apply
```
* Validate connectivity is as expected via `ping <IP address>` of the following endpoints:
    - VLAN21 gateway
    - OPNsense gateway
    - web
    - VLAN3
    - ubuntu1
    - ubuntu2
---------------------------------------------------------------------------
#### 14. Set up ubuntu4
* Set up VLAN22 in OPNsense:
* Interfaces > Other Types > VLAN > \[+\]
* Interfaces > Assignments > VLAN > \[+\]
* In interfaces appeared new options, edit
    - enable
    - description
    - static IP
    - IPv4 - set address
    - Service > DHCPv4
    - Firewall > Rules
      - Create a new rule(s) according to your VLAN to VLAN connectivity plan
      - Check 'Log packets that are handled by this rule' checkbox for each new rule
* Update ubuntu4 settings: Hardware > Network device > Edit > select v22 instead of vmbr0
* Go to Cloud-Init > edit DNS servers & IP Config:
  - 10.22.0.1
  - ip=10.22.0.14/24,gw=10.22.0.1
* Start ubuntu4
* Install _qemu-guest-agent_:
    
    ```
    sudo apt update
    sudo apt upgrade
    sudo apt install -y qemu-guest-agent
    sudo systemctl enable --now qemu-guest-agent
    ```

* Check the values set in _netplan_ configuration with `cat /etc/netplan/50-cloud-init.yaml` and in case any correction to network configuration (IP address, gateway & nameserver) is necessary, it might be done this way:
#### Note: DO NOT execute the below commands with `-i` flag unless the output of each command executed without it corresponds to your expectations.
```
sed -i -r 's/(\b[0-9]{1,3}\.){3}[1]{1}\b'/"10.22.0.1"/  /etc/netplan/50-cloud-init.yaml
sed -i -r "s/(\b[0-9]{1,3}\.){3}[0-9]{1,3}\/[0-9]{1,3}\b"/"10.22.0.14\/24"/  /etc/netplan/50-cloud-init.yaml
netplan apply
```
* Validate connectivity is as expected via `ping <IP address>` of the following endpoints:
    - VLAN22 gateway
    - OPNsense gateway
    - web
    - VLAN3
    - ubuntu1
    - ubuntu2
    - ubuntu3
---------------------------------------------------------------------------
#### 15. Create Ubuntu VMs on 3rd node
* Go to the git directory you've cloned from git:
```
cd $HOME/awesome-proxmox/vm-cloud-init-shell/
```
* Follow the [instructions](https://github.com/Alliedium/awesome-proxmox/blob/main/vm-cloud-init-shell/README.md) to copy `.env.example`, edit it (_Pz_VM_TEMPLATE_ID_, _Pz_VM_ID_PREFIX_, _Pz_TARGET_NODE_LIST_) and apply the updated environment settings.
* Run script to download cloud-init image on 3rd node:
```
./download-cloud-init-images.sh
```
* Run script to create Ubuntu cloud-init template on 3rd node:
```
./create-template.sh
```
* Run script to create 2 linked clones on 3rd node - ubuntu5 & ubuntu6:
```
./create-vms.sh
```
* DO NOT START VMS BEFORE SETUP
---------------------------------------------------------------------------
#### 16. Set up ubuntu5
* Update ubuntu5 settings: Hardware > Network device > Edit > select v20 instead of vmbr0
* Go to Cloud-Init > edit DNS servers & IP Config:
  - 10.20.0.1
  - ip=10.20.0.15/24,gw=10.20.0.1 
* Start ubuntu5
* Install _qemu-guest-agent_:
    
    ```
    sudo apt update
    sudo apt upgrade
    sudo apt install -y qemu-guest-agent
    sudo systemctl enable --now qemu-guest-agent
    ```

* Check the values set in _netplan_ configuration with `cat /etc/netplan/50-cloud-init.yaml` and in case any correction to network configuration (IP address, gateway & nameserver) is necessary, it might be done this way:
#### Note: DO NOT execute the below commands with `-i` flag unless the output of each command executed without it corresponds to your expectations.
```
sed -i -r 's/(\b[0-9]{1,3}\.){3}[1]{1}\b'/"10.20.0.1"/  /etc/netplan/50-cloud-init.yaml
sed -i -r "s/(\b[0-9]{1,3}\.){3}[0-9]{1,3}\/[0-9]{1,3}\b"/"10.20.0.15\/24"/  /etc/netplan/50-cloud-init.yaml
netplan apply
```
* Validate connectivity is as expected via `ping <IP address>` of the following endpoints:
    - VLAN20 gateway
    - OPNsense gateway
    - web
    - VLAN3
    - VLAN20 VMs
    - VLAN21 VMs
    - VLAN22 VMs
---------------------------------------------------------------------------
#### 17. Set up ubuntu6
* Update ubuntu6 settings: Hardware > Network device > Edit > select v22 instead of vmbr0
* Go to Cloud-Init > edit DNS servers & IP Config:
  - 10.22.0.1
  - ip=10.22.0.16/24,gw=10.22.0.1
* Start ubuntu6
* Install _qemu-guest-agent_:
    
    ```
    sudo apt update
    sudo apt upgrade
    sudo apt install -y qemu-guest-agent
    sudo systemctl enable --now qemu-guest-agent
    ```

* Check the values set in _netplan_ configuration with `cat /etc/netplan/50-cloud-init.yaml` and in case any correction to network configuration (IP address, gateway & nameserver) is necessary, it might be done this way:
#### Note: DO NOT execute the below commands with `-i` flag unless the output of each command executed without it corresponds to your expectations.
```
sed -i -r 's/(\b[0-9]{1,3}\.){3}[1]{1}\b'/"10.22.0.1"/  /etc/netplan/50-cloud-init.yaml
sed -i -r "s/(\b[0-9]{1,3}\.){3}[0-9]{1,3}\/[0-9]{1,3}\b"/"10.22.0.16\/24"/  /etc/netplan/50-cloud-init.yaml
netplan apply
```
* Validate connectivity is as expected via `ping <IP address>` of the following endpoints:
    - VLAN22 gateway
    - OPNsense gateway
    - web
    - VLAN3
    - VLAN20 VMs
    - VLAN21 VMs
    - VLAN22 VMs

### References ###

1. [Proxmox Network Configuration: VLAN](https://pve.proxmox.com/wiki/Network_Configuration#_vlan_802_1q)
2. [SDN plugin installation](https://pve.proxmox.com/pve-docs/chapter-pvesdn.html)
3. [Nested Virtualization in Proxmox](https://pve.proxmox.com/wiki/Nested_Virtualization)
4. [Proxmox Cluster Manager](https://pve.proxmox.com/wiki/Cluster_Manager)
5. [Regenerating Proxmox certificates](https://kimmo.suominen.com/blog/2019/12/regenerating-proxmox-certificates/)
6. [Cloud-init scripts](https://github.com/Alliedium/awesome-proxmox/tree/main/vm-cloud-init-shell)
