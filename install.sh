#!/bin/bash
git submodule update --init --recursive

if [ -x "$(command -v pip3)" ]; then
    pip3 install --user pynvim
fi

pushd ./.vim/bundle/LanguageClient-neovim
./install.sh
popd
