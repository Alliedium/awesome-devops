#!/bin/bash
set -e

MAIN_MSGCOLOR=`tput setaf 27`
NOCOLOR=`tput sgr0`

main_msg="${MAIN_MSGCOLOR}=======STOPPING, DESTROYING VMs and THE TEMPLATE${NOCOLOR}"
printf "${main_msg}...\n"

./start-stop-vms.sh stop
./destroy-vms.sh
./destroy-template.sh
printf "${main_msg}: done\n"
