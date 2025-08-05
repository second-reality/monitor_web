#!/usr/bin/env bash

set -euo pipefail

# build silently for 3 seconds, and restart if needed
timeout 3 podman build -q -t monitor-web - < ./Dockerfile ||
    podman build -t monitor-web - < ./Dockerfile

podman run \
    -it --rm -v $(pwd):$(pwd) -w $(pwd) --shm-size 1g --init \
    --privileged \
    -e DISABLE_CONTAINER_CHECK=1 \
    monitor-web \
    "$@"
