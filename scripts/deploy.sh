#!/bin/bash

set -e

APP_DIR=/home/ubuntu/app

cd $APP_DIR

echo "Pulling latest image..."

docker-compose pull

echo "Restarting containers..."

docker-compose down
docker-compose up -d