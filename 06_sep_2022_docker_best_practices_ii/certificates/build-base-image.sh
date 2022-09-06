#!/bin/sh
# Build base Docker image (if necessary, with certificates)
#
# Usage:
#   ./build-base-image.sh
#
set -e

if [ -f "$HOME/.certs/cacerts_all.crt" ] ; then
  if command -v md5 > /dev/null; then
    CERTS_CHECK_SUM=$(md5 $HOME/.certs/cacerts_all.crt | awk '{print $4}')
  else
    CERTS_CHECK_SUM=$(md5sum $HOME/.certs/cacerts_all.crt | awk '{print $1}')
  fi
  BASE_IMAGE_TAG=certs:${CERTS_CHECK_SUM}
  if docker image inspect $BASE_IMAGE_TAG > /dev/null 2> /dev/null; then
   echo "Image ${BASE_IMAGE_TAG} already exists, skip building"
  else
   docker build --file Dockerfile-certs --tag ${BASE_IMAGE_TAG} $HOME/.certs
  fi
else
  BASE_IMAGE_TAG=node:14.19.0-alpine3.15
fi
echo ${BASE_IMAGE_TAG}
