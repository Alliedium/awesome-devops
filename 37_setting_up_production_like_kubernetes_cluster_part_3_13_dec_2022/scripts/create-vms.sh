#!/bin/bash
set -e
#
MAIN_MSGCOLOR=`tput setaf 48`
MSGCOLOR=`tput setaf 3`
NOCOLOR=`tput sgr0`
ERRCOLOR=`tput setaf 196`
WARNCOLOR=`tput setaf 11`
WARNCOLOR1=`tput setaf 15`

main_msg="${MAIN_MSGCOLOR}=======Create VMs${NOCOLOR}"
printf "${main_msg}...\n"

eval "target_node_list=$Pz_TARGET_NODE_LIST"

for i_vm in $(seq $Pz_N_VMS)
do
   vm_cur_id=${Pz_VM_ID_PREFIX}${i_vm}
   vm_cur_name=${Pz_VM_NAME_PREFIX}${i_vm}
   if grep -q "\"$vm_cur_id\"" /etc/pve/.vmlist ; then
     printf "${WARNCOLOR}VM with ID ${MAIN_MSGCOLOR}$vm_cur_id${WARNCOLOR} already exists, ${WARNCOLOR1} creation skipped${NOCOLOR}\n"
   else
     msg="${MSGCOLOR}Creating VM $i_vm with ID=${vm_cur_id} and NAME=${vm_cur_name}${NOCOLOR}"
     printf "$msg...\n"
     qm clone $Pz_VM_TEMPLATE_ID ${vm_cur_id} --name ${vm_cur_name} --pool $Pz_POOL_ID $Pz_CLONE_FLAG
     printf "$msg: done\n"
     msg="${MSGCOLOR}Setting params${NOCOLOR}"
     printf "$msg...\n"
     qm set ${vm_cur_id}  --agent enabled=1,fstrim_cloned_disks=1,type=virtio

     target_node=${target_node_list[i_vm-1]}
     if [ `hostname` != ${target_node} ]; then
         msg="${MSGCOLOR}Migrating VM $i_vm with ID=${vm_cur_id} to node ${target_node}${NOCOLOR}"
         printf "$msg...\n"
         qm migrate ${vm_cur_id} ${target_node} --online --with-local-disks
         printf "$msg: done\n"
     else
         printf "${MSGCOLOR}VM $i_vm with ID=${vm_cur_id} is already on node $target_node, migration is skipped.${NOCOLOR}\n"
     fi
   fi
done
#
printf "${main_msg}: done\n"
 
