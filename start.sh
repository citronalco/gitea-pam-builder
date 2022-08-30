#!/bin/bash

if [ ! -f ./config.env ]; then
    echo "ERROR: config.env is missing."
    exit 1
fi

docker pull golang:bullseye

docker build --tag gitea-build-container ./dockerfiles

docker run \
    -ti --init \
    --volume "$(pwd)/source:/source" \
    --volume "$(pwd)/binary:/binary" \
    --env HOST_UID="$(id -u)" --env HOST_GID="$(id -g)" \
    --env-file ./config.env \
    gitea-build-container
