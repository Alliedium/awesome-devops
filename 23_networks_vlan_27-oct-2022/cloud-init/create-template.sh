#!/bin/bash
set -e
#
# Creates an initial PVE VM template which can then be used by ./multiply-vms.sh,
# please make sure to run ./download-cloud-init-images.sh prior to running this script!
#
# Usage:
#  $ ./create-initial-vm-template.sh
#
MAIN_MSGCOLOR=`tput setaf 48`
MSGCOLOR=`tput setaf 3`
NOCOLOR=`tput sgr0`

main_msg="${MAIN_MSGCOLOR}======Creating VM template${NOCOLOR}"
printf "$main_msg...\n"

msg="${MSGCOLOR}Creating VM${NOCOLOR}"
printf "$msg...\n"
# mtu=1 means use MTU of the host's bridge for the corresponding bridge
qm create $Pz_VM_TEMPLATE_ID --memory $Pz_RAM --cores $Pz_VCPU  \
  --name $Pz_VM_TEMPLATE_NAME --net0 virtio,bridge=$Pz_NET_BRIDGE,mtu=1 --pool $Pz_POOL_ID
printf "$msg: done\n"

msg="${MSGCOLOR}Making a copy of the disk image \"${Pz_IMG_FILE_NAME}\"${NOCOLOR}"
printf "$msg...\n"
modified_img_file_name=${Pz_IMG_FILE_NAME}.mod
cp $Pz_IMG_FILE_NAME $modified_img_file_name
printf "$msg: done\n"
#
if [ ! -z "$Pz_DISK_SIZE_INCREASE" ]
then
  msg="${MSGCOLOR}Resizing the disk image \"${modified_img_file_name}\" by $Pz_DISK_SIZE_INCREASE${NOCOLOR}"
  printf "$msg...\n"
  qemu-img resize $modified_img_file_name $Pz_DISK_SIZE_INCREASE
  printf "$msg: done\n"
fi
#
if [ "$Pz_DISK_FORMAT" == 'raw' ]; then
  import_disk_cmd_suffix=""
  after_import_disk_path="$Pz_DATA_STORAGE_ID:vm-$Pz_VM_TEMPLATE_ID-disk-0"
elif [ "$Pz_DISK_FORMAT" == 'qcow2' ]; then
  import_disk_cmd_suffix='--format qcow2'
  after_import_disk_path="$Pz_DATA_STORAGE_ID:$Pz_VM_TEMPLATE_ID/vm-$Pz_VM_TEMPLATE_ID-disk-0.qcow2"
else
  printf "${MSGCOLOR}Format $Pz_DISK_FORMAT is unsupported${NOCOLOR}"
  exit 1
fi

#
printf "${MSGCOLOR}Using DISK_FORMAT=$Pz_DISK_FORMAT${NOCOLOR}\n"
msg="${MSGCOLOR}Adding suffix $import_disk_cmd_suffix to qm import command${NOCOLOR}"
printf "$msg...\n"
qm importdisk $Pz_VM_TEMPLATE_ID $modified_img_file_name $Pz_DATA_STORAGE_ID $import_disk_cmd_suffix
printf "$msg: done\n"
#
msg="${MSGCOLOR}Attaching disk to VM using disk_path=${after_import_disk_path}${NOCOLOR}"
printf "$msg...\n"
qm set $Pz_VM_TEMPLATE_ID --scsihw virtio-scsi-pci --virtio0 $after_import_disk_path
printf "$msg: done\n"
#
msg="${MSGCOLOR}Setting various VM parameters${NOCOLOR}"
printf "$msg...\n"
qm set $Pz_VM_TEMPLATE_ID --ide2 $Pz_DATA_STORAGE_ID:cloudinit
qm set $Pz_VM_TEMPLATE_ID --boot c --bootdisk scsi0
qm set $Pz_VM_TEMPLATE_ID --agent enabled=1,fstrim_cloned_disks=1,type=virtio
printf "$msg: done\n"
#
msg="${MSGCOLOR}Setting CloudInit parameters${NOCOLOR}"
printf "$msg...\n"
qm set $Pz_VM_TEMPLATE_ID --nameserver $Pz_DNS
qm set $Pz_VM_TEMPLATE_ID --ciuser $Pz_USER_NAME
qm set $Pz_VM_TEMPLATE_ID --cipassword $Pz_USER_PW
qm set $Pz_VM_TEMPLATE_ID --sshkey $Pz_USER_PUB_KEY_FILE_NAME
printf "$msg: done\n"
#
msg="${MSGCOLOR}Converting VM to a template${NOCOLOR}"
printf "$msg...\n"
# The following command can throw a warning like the following one
#   "command '/usr/bin/chattr +i /mnt/pve/truenas-nfs/images/7000/base-7000-disk-0.qcow2' failed: exit code 1"
# on NFS storage
# because NFS doesn't have a concept of immutable files
# see https://unix.stackexchange.com/questions/90326/chattr-i-error-on-nfs for details
#
qm template $Pz_VM_TEMPLATE_ID
printf "$msg: done\n"
#
printf "$main_msg: done\n"
