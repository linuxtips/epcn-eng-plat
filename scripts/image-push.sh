#!/bin/bash
set -ex
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_DIR="$(dirname "$DIR")"

IMAGE_VERSION=$(cat "$REPO_DIR/version.txt")
REPOSITORY_NAME="epcn-repository"
IMAGE_NAME="go-hello"
IMAGE_TAG="$IMAGE_NAME:$IMAGE_VERSION"
CONTEXT_DIR="$REPO_DIR/apps/go-hello"

# ECR repo URI using env vars
ECR_REPO_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPOSITORY_NAME}"

docker build --progress=plain --no-cache -f "$CONTEXT_DIR/Containerfile" -t "$IMAGE_TAG" "$CONTEXT_DIR"
docker tag "$IMAGE_TAG" "$ECR_REPO_URI:$IMAGE_VERSION"
docker push "$ECR_REPO_URI:$IMAGE_VERSION"
