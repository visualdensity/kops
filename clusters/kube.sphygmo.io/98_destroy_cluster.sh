#!/bin/bash

set -eo pipefail

echo "This is going to DESTROY the cluster. ARE YOU SURE? (y/N)"
read yn

if [ "$yn" == "y" ];
then
  echo "One more time, THIS IS GOING TO DESTROY THE CLUSTER! Please type in CONFIRM to confirm: "
  read confirm

  if [ "$yn" == "y" ];
  then
    terraform apply output/terraform/destroy_cluster_plan
  fi
fi


echo "Cluster destroyed. You may want to unregister it from kops. Use the following command:"
echo "    kops delete cluster --unregister --name $KOPS_NAME --yes"
