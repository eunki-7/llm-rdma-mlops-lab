#!/usr/bin/env bash
set -euo pipefail
SERVER=${1:-10.0.0.10}
sudo apt-get install -y nfs-common
sudo mkdir -p /models /data /outputs
sudo mount -t nfs -o vers=4.2,noatime ${SERVER}:/models /models
sudo mount -t nfs -o vers=4.2,noatime ${SERVER}:/data /data
sudo mount -t nfs -o vers=4.2,noatime ${SERVER}:/outputs /outputs
