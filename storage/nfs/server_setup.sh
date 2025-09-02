#!/usr/bin/env bash
set -euo pipefail
sudo apt-get update && sudo apt-get install -y nfs-kernel-server
sudo mkdir -p /models /data /outputs
sudo bash -c 'cat >>/etc/exports <<EOF
/models  10.0.0.0/24(rw,async,no_subtree_check,no_root_squash)
/data    10.0.0.0/24(rw,async,no_subtree_check,no_root_squash)
/outputs 10.0.0.0/24(rw,async,no_subtree_check,no_root_squash)
EOF'
sudo exportfs -ra
sudo systemctl enable --now nfs-server
