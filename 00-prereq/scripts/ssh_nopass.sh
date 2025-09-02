#!/usr/bin/env bash
set -euo pipefail
# usage: ./ssh_nopass.sh node0 node1 node2 node3
for h in "$@"; do
  ssh-copy-id -o StrictHostKeyChecking=no "$USER@$h"
done
