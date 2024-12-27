#!/usr/bin/bash -e

RELEASE_VERSION="3.13.5"
RELEASE_URL="https://github.com/LuaLS/lua-language-server/releases/download/$RELEASE_VERSION/lua-language-server-$RELEASE_VERSION-linux-x64.tar.gz"
RELEASE_NAME="lls.tar.gz"
RELEASE_DIR="lls"

wget $RELEASE_URL -O $RELEASE_NAME
rm -rf $RELEASE_DIR
mkdir -p $RELEASE_DIR
tar xzf $RELEASE_NAME -C $RELEASE_DIR
rm $RELEASE_NAME
