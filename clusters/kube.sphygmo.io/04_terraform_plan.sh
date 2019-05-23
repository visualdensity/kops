#!/bin/bash

echo "Planning..."
terraform plan -out output/terraform/create_plan output/terraform
