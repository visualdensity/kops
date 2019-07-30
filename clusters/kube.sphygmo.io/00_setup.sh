#!/bin/bash

S3_BUCKET_NAME=wicked-kops-state 

# Setup S3 state store bucket
echo "Creating bucket '${S3_BUCKET_NAME}'..."
aws s3api create-bucket --bucket "${S3_BUCKET_NAME}" --region ap-southeast-1 --create-bucket-configuration LocationConstraint=ap-southeast-1

echo "Is the create successful? If so, we can apply the policy (y/n):"
read yn

if [ "$yn" == "y" ]; then
  # Apply bucket policy
  echo "Applying bucket policy..."
  aws s3api put-bucket-policy --bucket "${S3_BUCKET_NAME}" --policy file://kops_bucket_policy.json
else
  echo "Exiting"
  exit 0
fi
