FROM nvidia/cuda:12.4.1-devel-ubuntu22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    git python3-pip python3-venv numactl rdma-core ibverbs-utils openssh-client && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /workspace
COPY requirements.txt /workspace/requirements.txt
RUN pip3 install --upgrade pip && pip3 install -U --no-cache-dir -r requirements.txt
ENV NCCL_DEBUG=INFO
COPY ds_zero2.json train_sft.py launch_ds.sh .
RUN chmod +x launch_ds.sh
