#!/bin/bash
#
# Destroying PVE VMs (which are expected to be stopped)
#
# Usage:
#  $ ./destroy-vms.sh
#
set -e
MAIN_MSGCOLOR=`tput setaf 48`
MSGCOLOR=`tput setaf 3`
NOCOLOR=`tput sgr0`

main_msg="${MAIN_MSGCOLOR}========Destroying VMs${NOCOLOR}"
printf "$main_msg...\n"
eval "target_node_list=$Pz_TARGET_NODE_LIST"

for i_vm in $(seq $Pz_N_VMS)
do
   vm_cur_id=${Pz_VM_ID_PREFIX}${i_vm}
   target_node=${target_node_list[i_vm-1]}

   msg="${MSGCOLOR}Destroying VM $i_vm with ID=${vm_cur_id} on node $target_node${NOCOLOR}"
   printf "${msg}...\n"
   if grep -q "\"${vm_cur_id}\"" /etc/pve/.vmlist ; then
     pvesh delete /nodes/$target_node/qemu/$vm_cur_id -skiplock -destroy-unreferenced-disks -purge
   fi
   printf "${msg}: done\n"
done

printf "$main_msg: done\n"
