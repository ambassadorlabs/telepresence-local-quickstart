#! /usr/bin/env bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail

###### Check for prerequisites ######
### Check to see if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker could not be found, it is a prerequisite for Kind, please install Docker at https://docs.docker.com/get-docker/"
    exit
else
  echo "Docker installed, moving on!"
fi

### Check to see if kubectl is installed
if ! command -v kubectl &> /dev/null
then
    echo "kubectl could not be found, it is a prerequisite for this script, please install it at https://kubernetes.io/docs/tasks/tools/"
    exit
else
  echo "kubectl installed, moving on!"
fi

### Check to see if Telepresence is installed
if ! command -v telepresence &> /dev/null
then
  echo "Telepresence not installed, please install it at https://www.getambassador.io/docs/telepresence/latest/install"
  exit
else
  echo "Telepresence installed, moving on!"
fi

######

###### Create a Kind cluster ######
### Install Kind only if they don't have Kind
if ! command -v ./kind &> /dev/null
then
  # For AMD64 / x86_64
  [ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
  # For ARM64
  [ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-arm64
  chmod +x ./kind
else
  echo "Kind already installed, moving on!"
fi

### Create the cluster
if kubectl config use-context kind-telepresence-quickstart ;
then
  echo "telepresence-quickstart cluster already exists, moving on!"
else
  echo "Creating telepresence-quickstart cluster using kind"
  ./kind create cluster --name telepresence-quickstart
fi

### Make sure the kind context is the current one
kubectl config use-context kind-telepresence-quickstart

######

###### Install traffic manager ######
echo "Installing Telepresence traffic manager to cluster"
if telepresence helm install ;
then
  echo "Telepresence traffic manager successfully installed!"
else
  echo "Failed to install the Telepresence traffic manager."
fi

######

###### Install edgey-corp-python ######
echo "Installing sample app"
if kubectl apply -f ./edgey-corp-python/k8s-config/edgey-corp-web-app-no-mapping.yaml ;
then
  echo "Sample app successfully installed, you're ready to go through the rest of the quickstart!"
else
  echo "Failed to install the sample app."
fi

######
