FROM nvidia/cuda:12.4.1-cudnn-runtime-ubuntu24.04

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        python3 python3-pip python3-venv \
        ffmpeg libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip3 install --break-system-packages --upgrade pip && \
    pip3 install --break-system-packages -r requirements.txt

COPY . .

VOLUME ["/root/.cache/huggingface"]

EXPOSE 10300

ENTRYPOINT ["python3", "wyoming_vad_asr_server.py"]
