FROM nvidia/cuda:12.4.1-devel-ubuntu22.04
RUN apt-get update && apt-get install -y --no-install-recommends \
    git build-essential make cmake numactl hwloc rdma-core ibverbs-utils \
    openssh-client && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/NVIDIA/nccl-tests.git /opt/nccl-tests && \
    make -C /opt/nccl-tests MPI=0 CUDA_HOME=/usr/local/cuda
WORKDIR /workspace
ENV NCCL_DEBUG=INFO
