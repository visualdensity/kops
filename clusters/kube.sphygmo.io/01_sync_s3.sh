#!/bin/bash

echo "Syncing contrib/ with s3://${KOPS_BUCKET}/..."
aws s3 sync --acl authenticated-read --exclude README.md ./contrib s3://${KOPS_BUCKET}/contrib/
