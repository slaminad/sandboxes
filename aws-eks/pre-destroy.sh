#!/bin/sh

set -u
set -o pipefail
set -e


echo "executing error-destroy script"
aws eks update-kubeconfig --name $NUON_INSTALL_ID --alias $NUON_INSTALL_ID
kubectl delete namespace $NUON_INSTALL_ID --ignore-not-found=true
