FROM tensorflow/tensorflow:1.10.0
MAINTAINER "Daniel Sanche"

# add google cloud storage
RUN pip --no-cache-dir install \
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
