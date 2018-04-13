# tensorflow-model

This folder contains files necessary to build a container for a tf-job

- MNIST.py
  - contains TensorFlow code to train a model and upload the results to a Google Cloud Storage bucket
- Dockerfile
  - describes how to build a container to run the job

Note: before the container can be built, a service account key must be added to this folder that gives us access to the GCS bucket


---
This is not an officially supported Google product
