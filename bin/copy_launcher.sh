#!/bin/bash -e

cd $(git rev-parse --show-toplevel)

APP_DIR=~/.local/share/applications
mkdir -p $APP_DIR
cp ./bin/launcher/nvim.desktop $APP_DIR

ICON_DIR=~/.local/share/icons
mkdir -p $ICON_DIR
cp ./bin/launcher/nvim.png $ICON_DIR
