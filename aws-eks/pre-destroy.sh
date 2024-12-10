#!/bin/sh

set -u
set -o pipefail
set -e

echo "[pre-destroy] preparing to execute pre-destroy script"
aws sts get-caller-identity

echo "[pre-destroy] getting cluster credentials with aws eks update-kubeconfig"
aws eks update-kubeconfig --name $NUON_INSTALL_ID --alias $NUON_INSTALL_ID || echo "[pre-destroy] unable to get k8s credentials - exiting gracefully" exit 0

echo "[pre-destroy] deleting install namespace"
kubectl delete namespace $NUON_INSTALL_ID --ignore-not-found=true
