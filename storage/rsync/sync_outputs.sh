#!/usr/bin/env bash
set -euo pipefail
SRC=${1:-/local_nvme/outputs/}
DST=${2:-/outputs/}
rsync -avh --partial --inplace --delete "$SRC" "$DST"
