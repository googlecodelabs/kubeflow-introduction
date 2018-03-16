FROM ubuntu:16.04
MAINTAINER "Daniel Sanche"

# add TF dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python \
        python-dev \
        rsync \
        software-properties-common \
        unzip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# add python dependencies
RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

RUN pip --no-cache-dir install \
        Pillow \
        h5py \
        ipykernel \
        jupyter \
        matplotlib \
        numpy \
        pandas \
        scipy \
        sklearn \
        tensorflow \
        pudb \
        google-cloud-storage \
        && \
    python -m ipykernel.kernelspec

# include service account key
RUN mkdir /home/tensorflow
ADD key.json /home/tensorflow
ENV GOOGLE_APPLICATION_CREDENTIALS "/home/tensorflow/key.json"

# show python logs as they occur
ENV PYTHONUNBUFFERED=0

# include version and bucket as arguments to docker build
ARG version=1
ENV VERSION=$version
ARG bucket
ENV BUCKET=$bucket

# run MNIST.py with included arguments
ADD MNIST.py /home/tensorflow
WORKDIR /home/tensorflow
ENTRYPOINT /usr/bin/python /home/tensorflow/MNIST.py --version $VERSION --bucket $BUCKET
