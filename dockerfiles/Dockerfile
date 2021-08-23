FROM golang:bullseye

# build dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends git build-essential curl jq nodejs npm libpam-dev && \
    rm -rf /var/lib/apt/lists/*

# copy build script
COPY build.sh /build.sh

# run build script
ENTRYPOINT /build.sh
