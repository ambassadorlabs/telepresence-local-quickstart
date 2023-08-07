#! /usr/bin/env bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail

###### Check for prerequisites ######
### Check to see if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker could not be found, it is a prerequisite for Kind, please install Docker for your system."
    exit
fi

### Check to see if Telepresence is installed
if ! command -v telepresence &> /dev/null
then
  echo "Telepresence not installed, please install it from https://www.getambassador.io/docs/telepresence/latest/install and re-run this script."
else
  echo "Telepresence already installed, moving on!"
fi

######

###### Create a Kind cluster ######
### Install Kind only if they don't have Kind
if ! command -v kind &> /dev/null
then
  echo "Kind not installed, installing to /usr/local/bin/kind"
  # For Intel Macs
  [ "$(uname -m)" = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-darwin-amd64
  # For M1 / ARM Macs
  [ "$(uname -m)" = arm64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-darwin-arm64
  chmod +x ./kind
  sudo mv ./kind /usr/local/bin/kind
else
  echo "Kind already installed, moving on!"
fi

### Create the cluster
if kubectl config use-context kind-telepresence-quickstart ;
then
  echo "telepresence-quickstart cluster already exists, moving on!"
else
  echo "Creating telepresence-quickstart cluster using kind"
  kind create cluster -n telepresence-quickstart
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
