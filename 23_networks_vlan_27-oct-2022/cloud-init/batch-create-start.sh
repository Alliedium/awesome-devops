#!/bin/bash
set -e

MAIN_MSGCOLOR=`tput setaf 27`
NOCOLOR=`tput sgr0`

main_msg="${MAIN_MSGCOLOR}=======CREATING THE TEMPLATE, CREATING AND STARTING THE VMs${NOCOLOR}"
printf "${main_msg}...\n"
./create-template.sh
./create-vms.sh
./start-stop-vms.sh start
printf "${main_msg}: done\n"
