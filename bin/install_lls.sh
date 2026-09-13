#!/bin/bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."

RELEASE_VERSION=$(curl -fsSL https://api.github.com/repos/LuaLS/lua-language-server/releases/latest | jq -er '.tag_name | strings | select(length > 0)')
RELEASE_URL="https://github.com/LuaLS/lua-language-server/releases/download/$RELEASE_VERSION/lua-language-server-$RELEASE_VERSION-linux-x64.tar.gz"
STAGING_DIR=$(mktemp -d "$PWD/.lls.XXXXXXXXXX")
trap 'rm -rf -- "$STAGING_DIR"' EXIT
RELEASE_TARBALL="$STAGING_DIR/release.tar.gz"
RELEASE_DIR="$STAGING_DIR/lls"

curl -fL -o "$RELEASE_TARBALL" "$RELEASE_URL"
mkdir "$RELEASE_DIR"
tar xzf "$RELEASE_TARBALL" -C "$RELEASE_DIR"

# Keep the existing installation until extraction succeeds.
rm -rf -- lls
mv -- "$RELEASE_DIR" lls
