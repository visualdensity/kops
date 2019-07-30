#!/bin/bash

set -eo pipefail

echo "This is going to delete a few stuff like output/ and .terraform/files. Are you sure? (y/N)"
read yn

if [ "$yn" == "y" ];
then
    echo "Alright, resetting..."
    echo
    
    if [ -d "./output" ]; then
      echo "  -> Deleting output/..."
      rm -rf output/
      echo "  Done"
    fi
    echo

    cd .terraform
    if [ -d "./plugins/" ]; then
      echo "  -> Deleting .terraform/plugins/..."
      rm -rf ./plugins
      echo "  Done"
    fi
    echo

    if [ -f "./terraform.tfstate" ]; then
      echo "  -> Deleting ./terraform/terraform.tfstate..."
      rm -rf ./terraform.tfstate
      echo "  Done"
    fi
    echo

    echo "Delete S3 bucket (${KOPS_BUCKET}) too? (y/N)"
    read yS3

    if [ "$yS3" == "y" ];
    then
      echo "Removing S3 bucket ${KOPS_BUCKET}..."
      aws s3 rm --recursive s3://$KOPS_BUCKET
      aws s3api delete-bucket --bucket $KOPS_BUCKET
    fi

    echo "Ok. Reset completed."
else
    echo "Ok. Exited."
fi

exit 0
