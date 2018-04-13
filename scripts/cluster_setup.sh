#Copyright 2018 Google LLC

#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at

    #https://www.apache.org/licenses/LICENSE-2.0

#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.


PROJECT_ID=     #YOUR GCP PROJECT ID HERE
ZONE=us-central1-a
CLUSTER_NAME=kubeflow-codelab

# move to the ksonnet directory
cd "$( dirname "${BASH_SOURCE[0]}"  )"

# set config
gcloud config set project $PROJECT_ID
gcloud config set compute/zone $ZONE
# create the cluster
gcloud container clusters create $CLUSTER_NAME
# attach cluster to kubectl
gcloud container clusters get-credentials $CLUSTER_NAME
# add kubeflow namespace
kubectl create namespace kubeflow
kubectl config set-context $(kubectl config current-context) --namespace=kubeflow
# fix rbac issue
kubectl create clusterrolebinding default-admin --clusterrole=cluster-admin --user=$(gcloud config get-value account)

# add ksonnet to the cluster if available
if [ -d "ksonnet-kubeflow" ]; then
    cd ksonnet-kubeflow
    # add ks environment pointing to cluster
    ks env add cloud
    # apply kubeflow resources to cluster
    ks apply cloud -c kubeflow-core
fi
