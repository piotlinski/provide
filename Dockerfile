FROM nvcr.io/nvidia/cuda:11.3.1-cudnn8-devel-ubuntu18.04

RUN rm /etc/apt/sources.list.d/cuda.list

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -yqq && \
    apt-get install -yqq --no-install-recommends \
    git build-essential wget software-properties-common pkg-config \
    python3 python3-pip python3-setuptools vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip

COPY ./requirements.txt /tmp
RUN pip install -r /tmp/requirements.txt && \
    rm /tmp/requirements.txt

WORKDIR /workspace
COPY . /workspace/
ENV PYTHONPATH=$PYTHONPATH:/workspace/src
