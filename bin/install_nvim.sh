#!/bin/bash -e

INSTALL_DIR="/usr/local/bin"
INSTALL_PATH="$INSTALL_DIR/nvim"

if [ ! -f $INSTALL_PATH ]; then
    mkdir -p $INSTALL_DIR
    pushd $INSTALL_DIR
    sudo wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage
    sudo mv *.appimage nvim
    sudo chmod 755 nvim
    popd
fi

if which update-alternatives > /dev/null; then
    sudo update-alternatives --install /usr/bin/editor editor $INSTALL_PATH 110
fi
