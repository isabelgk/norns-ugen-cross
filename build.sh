#!/bin/bash
set -euo pipefail

docker buildx build -f Dockerfile.cross --tag cross-stretch .
docker buildx build -f Dockerfile.cross-pi --tag cross-pi .
docker buildx build -f Dockerfile --tag ugen-builder -o type=local,dest=./bin .