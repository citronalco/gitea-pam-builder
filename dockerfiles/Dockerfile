FROM golang:bullseye

# build dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends git build-essential curl jq libpam-dev && \
    rm -rf /var/lib/apt/lists/*

# install nodejs LTS from nodesource repository
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    rm -rf /var/lib/apt/lists/*

# copy build script
COPY build.sh /build.sh

# run build script
ENTRYPOINT /build.sh
