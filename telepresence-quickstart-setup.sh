#! /usr/bin/env bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail

###### Check for prerequisites
if ! command -v docker &> /dev/null
then
    echo "Docker could not be found, it is a prerequisite for Kind, please install Docker for your system."
    exit
fi

###### Create a Kind cluster ######
### Install Kind only if they don't have Kind
if ! command -v docker &> /dev/null
then
  echo "Kind not installed, installing to /usr/local/bin/kind"
  # For Intel Macs
  [ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-darwin-amd64
  # For M1 / ARM Macs
  [ $(uname -m) = arm64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-darwin-arm64
  chmod +x ./kind
  mv ./kind /usr/local/bin/kind
else
  echo "Kind already installed, moving on!"
fi

### Create the cluster

# install traffic manager


# install edgey-corp-python

