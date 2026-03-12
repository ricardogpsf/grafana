#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   Full build (Go + frontend):     ./build-and-push.sh TAG
#   Frontend-only (reuse Go binary): ./build-and-push.sh TAG ricardogpsf/grafana-dox:12.0.2-banner-2
IMAGE="ricardogpsf/grafana-dox"
TAG="${1:-12.0.2}"
GO_BINARY_IMAGE="${2:-}"

BUILD_ARGS="--platform linux/amd64 -f Dockerfile.dox -t ${IMAGE}:${TAG}"

if [[ -n "${GO_BINARY_IMAGE}" ]]; then
  echo "Frontend-only build — reusing Go binary from ${GO_BINARY_IMAGE}"
  BUILD_ARGS="${BUILD_ARGS} --build-arg GO_BINARY_IMAGE=${GO_BINARY_IMAGE}"
else
  echo "Full build (Go + frontend) …"
fi

echo "Building ${IMAGE}:${TAG} …"
docker build ${BUILD_ARGS} .

echo "Pushing ${IMAGE}:${TAG} …"
docker push "${IMAGE}:${TAG}"

echo "Done: ${IMAGE}:${TAG}"
