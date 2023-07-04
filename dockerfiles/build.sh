#!/bin/bash

# do not run as root, but as the calling user
if [ "$(id -u)" -eq 0 ]; then
    chown "${HOST_UID}":"${HOST_GID}" /source
    chown "${HOST_UID}":"${HOST_GID}" /binary
    exec setpriv --reuid="${HOST_UID}" --regid="${HOST_GID}" --clear-groups "$0"
fi

# setpriv does not set $HOME, so we have to do
export HOME=/source

# Fetch source
cd /source
if [ ! -d .git ]; then
    git init
    git remote add origin "${REPO_URL}"
else
    git remote set-url origin "${REPO_URL}"
fi
git fetch origin || exit 1

# Checkout latest release
GITHUB_REPO=$(echo "${REPO_URL}" | sed 'sX.*/\(.*/.*\)\.gitX\1X')
LATEST_RELEASE=$(curl --silent https://api.github.com/repos/${GITHUB_REPO}/releases/latest | jq -r .tag_name | sed 's/^\(v[[:digit:]]\.[[:digit:]]*\).*$/\1/')

git checkout release/"${LATEST_RELEASE}" || exit 1
git pull || exit 1

# clean
make clean

# build
CGO_ENABLED=1 TAGS="bindata sqlite sqlite_unlock_notify $EXTRA_TAGS" make build || exit 1

# move result to directory "binary"
VERSION=$(/source/gitea --version | cut -d ' ' -f 3) || exit 1
mv /source/gitea /binary/gitea-${VERSION} || exit 1

echo
echo "Sucessfully build /binary/gitea-${VERSION}"
