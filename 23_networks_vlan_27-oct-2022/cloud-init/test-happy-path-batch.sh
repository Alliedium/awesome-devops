#!/bin/bash
set -e
./download-cloud-init-images.sh
./batch-stop-destroy.sh
./batch-create-start.sh
./batch-stop-destroy.sh
