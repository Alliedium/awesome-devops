#!/bin/sh
# Build Docker image with Python dependencies
#
# Usage:
#   ./build-deps-image.sh
#
set -e

DEPS_IMAGE_NAME=deps

full_path=$(realpath $0)
dir_path=$(dirname $full_path)

PYTHON_REQ_CHECK_SUM=$($dir_path/get-python-req-check-sum.sh)

if docker image inspect ${DEPS_IMAGE_NAME}:PRCS-${PYTHON_REQ_CHECK_SUM} > /dev/null 2> /dev/null; then
  echo "Image ${DEPS_IMAGE_NAME}:PRCS-${PYTHON_REQ_CHECK_SUM} already exists, skip building"
else
  docker build --file $dir_path/Dockerfile-${DEPS_IMAGE_NAME} --tag ${DEPS_IMAGE_NAME}:PRCS-${PYTHON_REQ_CHECK_SUM} $dir_path
fi
echo ${DEPS_IMAGE_NAME}:PRCS-${PYTHON_REQ_CHECK_SUM}
