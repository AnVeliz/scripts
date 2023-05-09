#!/bin/bash

set -e

DIRECTORY=~/opt
LN_DIRECTORY=/home/me/.local/bin/

# Trap exit signal and execute cleanup function
trap cleanup EXIT

function cleanup() {
  echo "Cleaning up before exit..."
  rm ~/Downloads/telegram.xz || true
}

# Download the latest version of Visual Studio Code for Manjaro
wget -O ~/Downloads/telegram.xz "https://telegram.org/dl/desktop/linux"
if [ ! -d "${DIRECTORY}" ]; then
mkdir -p "${DIRECTORY}"
fi
if [ -d "${DIRECOTRY}/Telegram" ]; then
rm -rf "${DIRECOTRY}/Telegram"
fi
tar -xvf ~/Downloads/telegram.xz -C "${DIRECTORY}"

if [ ! -d "${LN_DIRECTORY}" ]; then 
mkdir -p "${LN_DIRECTORY}"
fi


# Create a symbolic link to the binary
ln -sf "$DIRECTORY/Telegram/Telegram" "/home/me/.local/bin/telegram"
