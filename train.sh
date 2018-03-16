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

TIMESTAMP=$(date +%s)
REGISTRY_PATH=us.gcr.io/$PROJECT_ID/tf-train:$TIMESTAMP

# build a container from our local code
echo "Building container..."
docker build -t $REGISTRY_PATH ./tensorflow-model --build-arg version=$TIMESTAMP --build-arg bucket=$GCS_BUCKET

# push to GCR
echo "Pushing container..."
gcloud docker -- push $REGISTRY_PATH

# run on cluster
cd ks-kubeflow
kubectl delete tfjobs --all
ks param set train image $REGISTRY_PATH
ks param set train name "train-"$TIMESTAMP
ks apply $KF_ENV -c train

# reset parameters
ks param set train image null
ks param set train name "train"

