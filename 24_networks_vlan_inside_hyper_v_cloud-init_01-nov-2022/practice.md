## Practice --- VLAN, CONFIGURATION THE HYPER-V

1. *Create virtual switches in* ***<font color="green">HYPER-V</font>***
* Open Virtual Switch Manager.
* Create External virtual switch with name `vmbr0`.
* Create Private virtual switch with name `vmbr1`.

2. Create virtual machines in ***<font color="green">HYPER-V</font>***
* Create `OPNsense` and `manjaro1`
  * Creating and setup is done as already shown
* Enable renaming for `OPNsense's` interfaces. Open `OPNsense's` settings in ***<font color="green">HYPER-V</font>***. &nbsp;Hit `+` on first network interface, go `Advanced Features` and check `Enable device naming`.
* Do the same for second `OPNsense's` network interface.
* Open `PowerShell` as adminstrator and run the script
```
# Name of the VM for which the NICs will be renamed
$VM = "OPNSense"
# Get a list of all the switches the $VM has NICs connected to
$VmSwitches = (Get-VMNetworkAdapter -VMName $VM).SwitchName
# Rename each NIC of the VM to the name of the virtual switch it is connected to
foreach ($C in $VmSwitches) { 
  Get-VMNetworkAdapter -VMName $VM `
  | Where-Object SwitchName -EQ $C `
  | Rename-VMNetworkAdapter -NewName $C -Verbose 
} 
```
* Enable Trunk for the switch `vmbr1` interface in `PowerShell`.

```
Get-VMNetworkAdapter -VMName OPNSense -Name vmbr1 |Set-VMNetworkAdapterVlan -Trunk -AllowedVlanIdList 3-22 -NativeVlanId 0
```
* In `OPNsense` add rule - allow untagged VLAN to untagged VLAN traffic only. Go to `OPNsense -> Firewall -> Rules -> LAN`, hit `+` and add corresponding rule.
* Check `manjaro1` connectivity in terminal.
  
  ```
  ping 10.0.0.1
  ```
  ```
  ping www.google.com
  ```
	
* See firewall log view `OPNsense -> Firewall -> Log Files -> Live View`.

3. Create `manjaro2` virtual machines in ***<font color="green">HYPER-V</font>***
* Enable Trunk for the `manjaro2` vmbr1 interface in `PowerShell`.
  
  ```
  Set-VMNetworkAdapterVlan -VMName manjaro2 -Trunk -AllowedVlanIdList 3-4 -NativeVlanId 0
  ```
  * In `manjaro2` terminal run NetworkManager command `nmtui` and setup VLAN 3, activate it and deactivate untagged VLAN - `Wired connection 1`
  * Check IP address asigned in VLAN 3
  ```
  ip a
  ```
  * Check `manjaro2` connectivity to internet, untagged VLAN and `manjaro1` in terminal.
  
  ```
  ping 10.3.0.1
  ```
  ```
  ping 10.0.0.1
  ```
  ```
  ping www.google.com
  ```
* See firewall log view `OPNsense -> Firewall -> Log Files -> Live View`.

4. Create `manjaro3` virtual machines in ***<font color="green">HYPER-V</font>***
* Setup `manjaro3` in VLAN 20  in ***<font color="green">HYPER-V</font>***. Go to - 
  `HYPER-V -> manjaro3's settings -> Network Adapter`, check  - `Enable virtual LAN identification` and setup `VLAN id`  -  20.
* Check IP address assigned in VLAN 20
  ```
  ip a
  ```
* Check `manjaro3` connectivity to internet, untagged VLAN, `manjaro1` and `manjaro2` in terminal.
  
  ```
  ping 10.20.0.1
  ```
  ```
  ping 10.0.0.1
  ```
    ```
  ping 10.3.0.1
  ```
  ```
  ping www.google.com
  ```
* See firewall log view `OPNsense -> Firewall -> Log Files -> Live View`.
-------------------------------------------------------------------------
## How to customize your cloud-init image

User is able to customize cloud init images by running script from https://github.com/Alliedium/awesome-proxmox/tree/main/vm-cloud-init-shell:
```
./customize-cloud-init-images.sh
```
This script uses libguestfs toolkit (namely https://libguestfs.org/virt-customize.1.html) to inject packages into the disk image without actually creating/starting a virtual machine. 
The presence of libguestfs-tools package on on the proxmox node is checked by the script and if the package is missing - it is installed automatically.
The script might be executed after downloading images. It creates a custom version of an existing original image.
The related variables in .env file are:
1. the comma-separated list of packages to be installed into the image prior to vm creation
```
Pz_CLOUD_INIT_INSTALL_PKG_LIST="qemu-guest-agent" 
```
2. image which is used: ".orig" for original downloaded images or ".custom" for customized images.
```
Pz_IMG_FILE_NAME=$Pz_CLOUD_INIT_IMAGE_DIR/jammy-server-cloudimg-amd64.img.custom 
```
