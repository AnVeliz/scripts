#!/bin/bash

set -e

DIRECTORY=~/opt
LN_DIRECTORY=/home/me/.local/bin/

# Trap exit signal and execute cleanup function
trap cleanup EXIT

function cleanup() {
  echo "Cleaning up before exit..."
  rm ~/Downloads/vscode.tar.gz || true
}

# Download the latest version of Visual Studio Code for Manjaro
wget -O ~/Downloads/vscode.tar.gz "https://code.visualstudio.com/sha/download?build=stable&os=linux-x64"
if [ ! -d "${DIRECTORY}" ]; then
mkdir -p "${DIRECTORY}"
fi
if [ -d "${DIRECTORY}/VSCode-linux-x64" ]; then
rm -rf "${DIRECTORY}/VSCode-linux-x64"
fi
tar -xzvf ~/Downloads/vscode.tar.gz -C "${DIRECTORY}"

if [ ! -d "${LN_DIRECTORY}" ]; then 
mkdir -p "${LN_DIRECTORY}"
fi


# Create a symbolic link to the binary
ln -sf "$DIRECTORY/VSCode-linux-x64/bin/code" "/home/me/.local/bin/code"

