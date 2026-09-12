#!/bin/bash
set -euo pipefail

pushd "$(git rev-parse --show-toplevel)"

RELEASE_VERSION=$(curl -fsSL https://api.github.com/repos/LuaLS/lua-language-server/releases/latest | jq -er '.tag_name | strings | select(length > 0)')
RELEASE_URL="https://github.com/LuaLS/lua-language-server/releases/download/$RELEASE_VERSION/lua-language-server-$RELEASE_VERSION-linux-x64.tar.gz"
RELEASE_TARBALL=$(mktemp)
trap 'rm -f "$RELEASE_TARBALL"' EXIT
RELEASE_DIR="lls"

curl -fL -o "$RELEASE_TARBALL" "$RELEASE_URL"
tar tzf "$RELEASE_TARBALL" > /dev/null
rm -rf "$RELEASE_DIR"
mkdir -p "$RELEASE_DIR"
tar xzf "$RELEASE_TARBALL" -C "$RELEASE_DIR"

popd
