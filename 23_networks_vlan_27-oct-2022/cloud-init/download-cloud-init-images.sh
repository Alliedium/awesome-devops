#!/bin/bash
set -e
#
# Downloads PVE VM Cloud Init images to the predefined folder. Downloading is done in an atomic fashion to
# avoid broken/partially downloaded images.
#
# Usage:
#  $ ./download-cloud-init-images.sh
#
MAIN_MSGCOLOR=`tput setaf 48`
MSGCOLOR=`tput setaf 3`
NOCOLOR=`tput sgr0`

main_msg="${MAIN_MSGCOLOR}======Downloading cloud images${NOCOLOR}"
printf "$main_msg...\n"

mkdir -p $Pz_CLOUD_INIT_IMAGE_DIR

eval "link_list=$Pz_LINK_LIST"

for dl_url in "${link_list[@]}"
do
  msg="${MSGCOLOR}Downloading $dl_url${NOCOLOR}"
  printf "$msg...\n"
  file_name=${Pz_CLOUD_INIT_IMAGE_DIR}/$(basename "$dl_url")
  file_name_tmp=${file_name}.tmp
  if [[ ! -e "$file_name" ]]
  then
    wget -O ${file_name_tmp} $dl_url -c && mv ${file_name}{.tmp,}
  else
    # clean garbage
    [ -e $file_name_tmp ] && rm ${file_name_tmp}
  fi
  printf "$msg: done\n"
done
printf "$main_msg: done\n"

