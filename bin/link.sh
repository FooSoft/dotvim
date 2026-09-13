#!/bin/bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
TARGET="$CONFIG_DIR/nvim"
mkdir -p -- "$CONFIG_DIR"
if [ "$TARGET" -ef "$PWD" ]; then
    exit 0
fi
if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
    printf 'Cannot link: %s already exists and points elsewhere.\n' "$TARGET" >&2
    exit 1
fi
ln -s -- "$PWD" "$TARGET"
