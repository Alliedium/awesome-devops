#!/bin/bash
set -e
# uncomment next line while launching for the first time:
# pvesh create /pools --poolid cloudinit-vms
qm create 6000 --memory 4096 --cores 4  --name rocky9-cloud --net0 virtio,bridge=vmbr0 --pool cloudinit-vms
qemu-img resize /root/Rocky-9-GenericCloud-9.0-20220706.0.x86_64.qcow2 +2G
qm importdisk 6000 /root/Rocky-9-GenericCloud-9.0-20220706.0.x86_64.qcow2 local-lvm
qm set 6000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-6000-disk-0
qm set 6000 --ide2 local-lvm:cloudinit
qm set 6000 --boot c --bootdisk scsi0
qm set 6000 --serial0 socket --vga serial0
#for Rocky9
qm set 6000 --machine q35 --bios ovmf --cpu host
qm set 6000 --efidisk0 local-lvm:0
#
qm clone 6000 6001 --name rocky9-cloud-template -pool cloudinit-vms --full
#
qm set 6001 --sshkey ~/.ssh/id_rsa_cloudinit.pub
qm set 6001 --ipconfig0 ip=10.115.176.13/24,gw=10.115.176.1
qm set 6001 --nameserver 10.115.176.1
qm set 6001 --ciuser tatyana
#
qm template 6001
#
qm clone 6001 6014 --name rocky1 --pool cloudinit-vms --full
qm set 6014 --ipconfig0 ip=10.115.176.14/24,gw=10.115.176.1
qm start 6014
#
qm clone 6001 6015 --name rocky2 --pool cloudinit-vms --full
qm set 6015 --ipconfig0 ip=10.115.176.15/24,gw=10.115.176.1
qm start 6015
#
qm clone 6001 6016 --name rocky3 --pool cloudinit-vms --full
qm set 6016 --ipconfig0 ip=10.115.176.16/24,gw=10.115.176.1
qm start 6016
