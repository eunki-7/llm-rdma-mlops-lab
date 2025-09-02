FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04
RUN apt-get update && apt-get install -y --no-install-recommends python3-pip &&     rm -rf /var/lib/apt/lists/*
RUN pip3 install --upgrade pip && pip3 install -U vllm==0.5.4 "transformers>=4.43.3"
WORKDIR /workspace
ENV VLLM_WORKER_MULTIPROC_METHOD=spawn
COPY start_vllm.sh .
RUN chmod +x start_vllm.sh
