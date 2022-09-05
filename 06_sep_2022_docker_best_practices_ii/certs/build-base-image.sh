#!/bin/sh
# Build base Docker image (if necessary, with certificates)
#
# Usage:
#   ./build-base-image.sh
#
set -e

if [ -d "$HOME/.certs" ] ; then
  if [ $(find $HOME/.certs/ -type f -prune -print | grep -c /) -eq 0 ] ; then
    echo "Folder $HOME/.certs is expected to contain certificates" >&2; exit 1
  else
    if command -v md5 > /dev/null; then
      CERTS_CHECK_SUM=$(find $HOME/.certs/ -type f -exec md5 {} + | awk '{print $4}' | sort | md5)
    else
      CERTS_CHECK_SUM=$(find $HOME/.certs/ -type f -exec md5sum {} + | awk '{print $1}' | sort | md5sum | awk '{print $1}')
    fi
    BASE_IMAGE_TAG=certs:${CERTS_CHECK_SUM}
    if docker image inspect $BASE_IMAGE_TAG > /dev/null 2> /dev/null; then
      echo "Image ${BASE_IMAGE_TAG} already exists, skip building"
    else
      docker build --file Dockerfile-certs --tag ${BASE_IMAGE_TAG} $HOME/.certs
    fi
  fi
else
  echo "Folder $HOME/.certs with certificates is expected to exist" >&2; exit 1
fi
echo ${BASE_IMAGE_TAG}
