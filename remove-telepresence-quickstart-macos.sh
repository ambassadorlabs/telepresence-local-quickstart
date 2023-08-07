#! /usr/bin/env bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail

echo "Deleting kind-telepresence-quickstart cluster"
kind delete cluster -n telepresence-quickstart

echo "Removing kind binary installed at /usr/local/bin/kind"
sudo rm -rf /usr/local/bin/kind
