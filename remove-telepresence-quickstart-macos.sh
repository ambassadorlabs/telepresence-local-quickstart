#! /usr/bin/env bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail

kind delete cluster -n telepresence-quickstart
sudo rm -rf /usr/local/bin/kind
