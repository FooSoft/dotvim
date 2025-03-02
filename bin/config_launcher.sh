#!/bin/bash -e

APP_DIR=~/.local/share/applications
mkdir -p $APP_DIR
cp launcher/nvim.desktop $APP_DIR

ICON_DIR=~/.local/share/icons
mkdir -p $ICON_DIR
cp launcher/nvim.png $ICON_DIR
