#!/bin/bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."

DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"
APP_DIR="$DATA_DIR/applications"
mkdir -p "$APP_DIR"
cp ./bin/launcher/nvim.desktop "$APP_DIR"

ICON_DIR="$DATA_DIR/icons"
mkdir -p "$ICON_DIR"
cp ./bin/launcher/nvim.png "$ICON_DIR"
