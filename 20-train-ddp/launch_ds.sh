#!/usr/bin/env bash
set -euo pipefail
exec torchrun   --nproc_per_node ${NPROC_PER_NODE:-1}   --nnodes ${NNODES:-4}   --node_rank ${NODE_RANK:-0}   --master_addr ${MASTER_ADDR:-127.0.0.1}   --master_port ${MASTER_PORT:-29500}   train_sft.py
