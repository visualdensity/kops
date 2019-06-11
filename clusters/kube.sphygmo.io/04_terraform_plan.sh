#!/bin/bash

set -eo pipefail

echo "Planning..."
terraform plan -out output/terraform/create_plan output/terraform
