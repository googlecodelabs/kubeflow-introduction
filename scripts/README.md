# Kubeflow Scripts

The scripts in this folder aren't necessary for the codelab, but they can be used to assist with building your own custom workflows

- cluster_setup.sh
  - creates a new GKE cluster and initializes it with the kubeflow-core components
- train.sh
  - builds the training container and pushes it up as a tf-job
  - idempotent; can be run each time you want to push a new build
  - may be included as a git hook to send a train job with each commit
- serve.sh
  - builds and deploys a tf-serve job, and a new container for the web ui
  - should only need to be run once on set up, but this one is also idempotent


---
This is not an officially supported Google product
