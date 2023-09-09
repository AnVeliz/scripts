#!/bin/bash

set -e

DIRECTORY=~/opt
LN_DIRECTORY=/home/me/.local/bin/

ZAP_LATEST_VERSION="$(curl -s "https://api.github.com/repos/zaproxy/zaproxy/releases/latest" | jq -r '.tag_name')"
ZAP_LATEST_SHORT_VERSION=${ZAP_LATEST_VERSION//v/}

# Trap exit signal and execute cleanup function
trap cleanup EXIT

function cleanup() {
  echo "Cleaning up before exit..."
  rm ~/Downloads/zap.tar.gz || true
}

wget -O ~/Downloads/zap.tar.gz "https://github.com/zaproxy/zaproxy/releases/download/${ZAP_LATEST_VERSION}/ZAP_${ZAP_LATEST_SHORT_VERSION}_Linux.tar.gz"
if [ ! -d "${DIRECTORY}" ]; then
mkdir -p "${DIRECTORY}"
fi
if [ -d "${DIRECTORY}/ZAP_${ZAP_LATEST_SHORT_VERSION}" ]; then
rm -rf "${DIRECTORY}/ZAP_${ZAP_LATEST_SHORT_VERSION}"
fi
tar -xzvf ~/Downloads/zap.tar.gz -C "${DIRECTORY}"

if [ ! -d "${LN_DIRECTORY}" ]; then 
mkdir -p "${LN_DIRECTORY}"
fi


# Create a symbolic link to the binary
ln -sf "$DIRECTORY/ZAP_${ZAP_LATEST_SHORT_VERSION}/zap.sh" "/home/me/.local/bin/zap"
