#!/bin/bash

set -e

IMAGE_NAME=$1

echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

echo "Building Docker image..."

docker build -t $IMAGE_NAME .

echo "Pushing Docker image..."

docker push $IMAGE_NAME