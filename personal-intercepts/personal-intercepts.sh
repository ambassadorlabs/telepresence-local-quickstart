#! /usr/bin/env bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail

#kubectl config use-context kind-telepresence-quickstart
#telepresence helm upgrade --team-mode
#helm repo add jetstack https://charts.jetstack.io && helm repo update
#helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --set installCRDs=true
#kubectl apply -f https://github.com/open-telemetry/opentelemetry-operator/releases/latest/download/opentelemetry-operator.yaml

# this first one may fail if the cluster hasn't updated the CRDs yet from the operator and doesn't know what an Instrumentation is
kubectl apply -f instrumentation.yaml
kubectl apply -f verylargejavaservice.yaml
kubectl apply -f dataprocessingservice.yaml

#telepresence connect
#telepresence intercept --http-header='baggage=.*devid=123456.*' --port 3000 dataprocessingservice
