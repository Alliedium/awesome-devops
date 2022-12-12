#!/bin/bash
#
# Starting/stopping PVE VMs
#
# Usage:
#  $ ./start-stop-vms.sh stop
#  $ ./start-stop-vms.sh start
#
set -e
MAIN_MSGCOLOR=`tput setaf 48`
MSGCOLOR=`tput setaf 3`
NOCOLOR=`tput sgr0`
ERRCOLOR=`tput setaf 196`

eval "target_node_list=$Pz_TARGET_NODE_LIST"

if [ $1 == 'start' ]; then
   status_msg='Starting'
elif [ $1 == 'stop' ]; then
   status_msg='Stopping'
elif [ -z $1 ]; then
   printf "${ERRCOLOR}Please specify the target staus as either 'start' or 'stop'\n${NOCOLOR}"
   exit 1
else
   printf "${ERRCOLOR}Unknown target status $1\n${NOCOLOR}"
   exit 1
fi
vm_status2set=$1

main_msg="${MAIN_MSGCOLOR}========$status_msg VMs${NOCOLOR}"
printf "$main_msg...\n"

for i_vm in $(seq $Pz_N_VMS)
do
   vm_cur_id=${Pz_VM_ID_PREFIX}${i_vm}
   target_node=${target_node_list[i_vm-1]}

   msg="${MSGCOLOR}$status_msg VM $i_vm with ID=${vm_cur_id} on node $target_node${NOCOLOR}"
   printf "${msg}...\n"
   if grep -q "\"${vm_cur_id}\"" /etc/pve/.vmlist ; then
     pvesh create /nodes/$target_node/qemu/$vm_cur_id/status/$vm_status2set
   fi
   printf "${msg}: done\n"
done

printf "$main_msg: done\n"
