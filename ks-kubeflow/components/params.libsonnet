{
  global: {
    // User-defined global parameters; accessible to all component and environments, Ex:
    // replicas: 4,
  },
  components: {
    // Component-level parameters, defined initially from 'ks prototype use ...'
    // Each object below should correspond to a component in the components/ directory
    "kubeflow-core": {
      cloud: "gke",
      disks: "null",
      jupyterHubAuthenticator: "null",
      jupyterHubImage: "gcr.io/kubeflow/jupyterhub-k8s:1.0.1",
      jupyterHubServiceType: "ClusterIP",
      name: "kubeflow-core",
      namespace: "kubeflow",
      reportUsage: "false",
      tfAmbassadorServiceType: "ClusterIP",
      tfDefaultImage: "null",
      tfJobImage: "gcr.io/kubeflow-images-staging/tf_operator:v20180226-403",
      tfJobUiServiceType: "ClusterIP",
      usageId: "unknown_cluster",
    },
    train: {
      args: "null",
      image: "null",
      image_gpu: "null",
      name: "train",
      namespace: "kubeflow",
      num_gpus: 0,
      num_masters: 1,
      num_ps: 0,
      num_workers: 0,
    },
    server: {
      modelPath: "null",
      name: "server",
      namespace: "kubeflow",
    },
    "web-ui": {
      containerPort: 5000,
      image: "null",
      name: "web-ui",
      namespace: "kubeflow",
      replicas: 1,
      servicePort: 80,
      type: "LoadBalancer",
    },
  },
}
