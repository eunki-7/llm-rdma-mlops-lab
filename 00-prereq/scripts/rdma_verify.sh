#!/usr/bin/env bash
set -euo pipefail
which ibv_devinfo && ibv_devinfo | egrep 'hca_id|phys_port_cnt|state|link_layer' || echo "ibv_devinfo N/A"
dmesg | egrep -i 'rdma|mlx|efa|roce' | tail -n 50 || true
