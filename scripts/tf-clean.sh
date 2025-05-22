#!/bin/bash

# Find and delete Terraform state and temp files

find . -type f \( \
    -name "*.tfstate" -o \
    -name "*.tfstate.backup" -o \
    -name "*.tfplan" -o \
    -name ".terraform.lock.hcl" -o \
    -name ".terraform.tfstate" -o \
    -name ".terraform.tfstate.backup" \
\) -exec rm -f {} +

# Remove .terraform directories
find . -type d -name ".terraform" -prune -exec rm -rf {} +

echo "Terraform state and temp files deleted."