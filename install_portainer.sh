#!/bin/bash

set -e

echo "Stopping and removing any existing Portainer container..."
docker stop portainer 2>/dev/null || true
docker rm portainer 2>/dev/null || true

echo "Creating volume for Portainer (if not exists)..."
docker volume create portainer_data

echo "Starting Portainer (HTTP only on port 9000)..."
docker run -d \
  -p 9000:9000 \
  --name portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest

echo "✅ Portainer is running and accessible at: http://localhost:9000"
echo "Or: http://<your-server-ip>:9000"

