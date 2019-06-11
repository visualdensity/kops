#!/bin/bash

set -eo pipefail

echo "Creating cluster config from cluster.yaml..."
kops create -f cluster.yaml

echo "Creating secret..."
kops create secret --name $KOPS_NAME sshpublickey admin -i ~/.ssh/id_rsa.pub

echo "Generating terraform configs using kops..."
kops update cluster --out output/terraform --target terraform --name $KOPS_NAME
