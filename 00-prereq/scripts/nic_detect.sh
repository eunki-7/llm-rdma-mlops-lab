#!/usr/bin/env bash
set -euo pipefail
echo "[NIC brief]"; ip -br a
echo; echo "[Routes]"; ip route
echo; echo "[RDMA devices]"; (ibv_devinfo || true)
echo; echo "[PCI]"; lspci | egrep -i 'nvidia|mellanox|ethernet'
