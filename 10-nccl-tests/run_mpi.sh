#!/usr/bin/env bash
set -euo pipefail
HF=${1:-./hostfile.example}
export NCCL_DEBUG=INFO
export NCCL_SOCKET_IFNAME=${NCCL_SOCKET_IFNAME:-ib0}
export NCCL_IB_HCA=${NCCL_IB_HCA:-mlx5}
mpirun -np 4 -hostfile $HF \
  -x NCCL_DEBUG -x NCCL_SOCKET_IFNAME -x NCCL_IB_HCA \
  --mca btl ^openib \
  docker run --rm --net=host --gpus all \
    -e NCCL_DEBUG -e NCCL_SOCKET_IFNAME -e NCCL_IB_HCA \
    nccl-tests:local \
    /opt/nccl-tests/build/all_reduce_perf -b 8 -e 1G -f 2 -g 1
