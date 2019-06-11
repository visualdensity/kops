#!/bin/bash

set -eo pipefail

if [ -d "./output/terraform" ]; then
    cp ./.terraform/backend.tf ./output/terraform/
fi

echo "Initialising terraform in output/terraform/..."
terraform init -backend-config="key=terraform/${KOPS_NAME}/terraform.tfstate" -backend-config="bucket=${KOPS_BUCKET}" output/terraform/
