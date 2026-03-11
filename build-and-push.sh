#!/usr/bin/env bash
set -euo pipefail

# Tag mirrors the Grafana base version so it's clear what version we built on.
# Usage: ./build-and-push.sh [tag]   (default: 12.0.2)
IMAGE="ricardogpsf/grafana-dox"
TAG="${1:-12.0.2}"

echo "Building ${IMAGE}:${TAG} …"

docker build \
  --platform linux/amd64 \
  -f Dockerfile.dox \
  -t "${IMAGE}:${TAG}" \
  .

echo "Pushing ${IMAGE}:${TAG} …"
docker push "${IMAGE}:${TAG}"

echo "Done: ${IMAGE}:${TAG}"
