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
GCS_BUCKET=     #YOUR GCS BUCKET HERE
KF_ENV=cloud

REGISTRY_PATH=us.gcr.io/$PROJECT_ID/tf-webui

# move to the main project directory
cd "$( dirname "${BASH_SOURCE[0]}"  )"
cd ..

# build a container from our local code
echo "Building container..."
docker build -t $REGISTRY_PATH ./web-ui

# push to GCR
echo "Pushing container..."
gcloud docker -- push $REGISTRY_PATH

# delete old deployments, so container is updated
kubectl delete deployment web-ui
kubectl delete deployment server

if [ -d "ksonnet-kubeflow" ]; then
    # apply the server/ui components to the cluster
    cd ksonnet-kubeflow
    ks param set server modelPath gs://$GCS_BUCKET
    ks apply $KF_ENV -c server
    ks param set web-ui image $REGISTRY_PATH
    ks apply $KF_ENV -c web-ui -n kubeflow

    # reset parameters
    ks param set server modelPath null
    ks param set web-ui image null
fi
