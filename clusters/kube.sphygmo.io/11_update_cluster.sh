#!/bin/bash

set -eo pipefail

echo "Replacing cluster config..."
kops replace --name $KOPS_NAME -f cluster.yaml
echo "Done"


echo "Generating terraform configs using kops..."
kops update cluster --out output/terraform --target terraform --name $KOPS_NAME
echo "Done"
echo 

echo "Please run 04_terraform_plan.sh to create a terraform plan, then ./05_terraform_apply.sh to apply the changes"
