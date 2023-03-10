#!/bin/bash
set -eu -o pipefail

DOCKER_REPO=${DOCKER_REPO:-ddev/ddev-utilities:latest}

echo "Pushing ${DOCKER_REPO}"
if ! docker buildx inspect ddev-builder-multi --bootstrap >/dev/null; then docker buildx create --name ddev-builder-multi; fi
docker buildx use ddev-builder-multi
set -x
docker buildx build -t ${DOCKER_REPO} --platform linux/amd64,linux/arm64 --push .
