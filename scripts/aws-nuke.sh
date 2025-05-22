#!/bin/bash
# Script to run aws-nuke to remove all resources from an AWS account

set -ex

# Path to your aws-nuke config file
CONFIG_FILE="aws-nuke.yaml"

# Check if aws-nuke is installed
if ! command -v aws-nuke &> /dev/null; then
    echo "aws-nuke could not be found. Please install it first."
    exit 1
fi

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Config file $CONFIG_FILE not found, generating a new one."
    envsubst < aws-nuke.env.yaml > "$CONFIG_FILE"
fi

# Run aws-nuke
aws-nuke run \
    --no-alias-check \
    --no-dry-run \
    -c "$CONFIG_FILE" \
    "$@"
