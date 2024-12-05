#!/bin/sh

set -u
set -o pipefail


echo "executing error-destroy script"
echo
echo '     region: '$AWS_REGION
echo '    profile: '$AWS_PROFILE
echo ' install id: '$NUON_INSTALL_ID
echo


echo "list deployments in install namespace"
kubectl -n $NUON_INSTALL_ID get deployments -o json
