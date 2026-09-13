#!/bin/bash
set -euo pipefail

INSTALL_DIR="/usr/local/bin"
INSTALL_PATH="$INSTALL_DIR/nvim"

DOWNLOAD_PATH=$(mktemp)
trap 'rm -f "$DOWNLOAD_PATH"' EXIT
wget -O "$DOWNLOAD_PATH" https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage
sudo install -D -m 755 "$DOWNLOAD_PATH" "$INSTALL_PATH"

if command -v update-alternatives > /dev/null; then
    bash "$(dirname -- "${BASH_SOURCE[0]}")/update_editor.sh"
fi
