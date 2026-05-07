#!/bin/bash

set -e

APP_DIR=/opt/app

mkdir -p $APP_DIR

cp docker-compose.yml $APP_DIR

cd $APP_DIR

echo "Pulling latest image..."

docker-compose pull

echo "Restarting containers..."

docker-compose down
docker-compose up -d