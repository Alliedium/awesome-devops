#!/bin/sh
# Get MD5 check sum for the files within the project connected to Python requirements
#
# Usage:
#   ./get-python-req-check-sum.sh
#
set -e

full_path=$(realpath $0)
dir_path=$(dirname $full_path)

if command -v md5 > /dev/null; then
  PYTHON_REQ_CHECK_SUM=$(find $dir_path/ \( -name python_env_install.py -or -name python_requirements.yml \) -type f -exec md5 {} + | awk '{print $4}' | sort | md5)
else
  PYTHON_REQ_CHECK_SUM=$(find $dir_path/ \( -name python_env_install.py -or -name python_requirements.yml \) -type f -exec md5sum {} + | awk '{print $1}' | sort | md5sum | awk '{print $1}')
fi
echo "${PYTHON_REQ_CHECK_SUM}"