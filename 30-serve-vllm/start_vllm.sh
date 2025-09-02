#!/usr/bin/env bash
set -euo pipefail
python3 -m vllm.entrypoints.api_server   --model ${MODEL_NAME}   --tensor-parallel-size ${TP_SIZE:-1}   --host ${HOST:-0.0.0.0}   --port ${PORT:-8000}   --max-model-len ${MAX_MODEL_LEN:-4096}   --metrics
