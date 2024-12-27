#!/usr/bin/bash -e

RELEASE_VERSION=$(curl -sL https://api.github.com/repos/LuaLS/lua-language-server/releases/latest | jq -r ".tag_name")
RELEASE_URL="https://github.com/LuaLS/lua-language-server/releases/download/$RELEASE_VERSION/lua-language-server-$RELEASE_VERSION-linux-x64.tar.gz"
RELEASE_TARBALL="lls.tar.gz"
RELEASE_DIR="lls"

curl -L -o $RELEASE_TARBALL $RELEASE_URL
rm -rf $RELEASE_DIR
mkdir -p $RELEASE_DIR
tar xzf $RELEASE_TARBALL -C $RELEASE_DIR
rm $RELEASE_TARBALL
