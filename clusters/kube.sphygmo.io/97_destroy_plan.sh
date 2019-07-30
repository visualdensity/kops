#!/bin/bash

set -eo pipefail

echo "Planning on how to destroy cluster..."
terraform plan -destroy -out output/terraform/destroy_cluster_plan output/terraform
