#!/bin/bash

docker pull devamu/dev:latest

docker stop frontend || true
docker rm frontend || true

docker run -d --name frontend -p 80:80 devamu/dev:latest