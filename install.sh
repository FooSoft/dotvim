#!/bin/bash

git submodule update --init --recursive

if [ -x "$(command -v pip2)" ]; then
    pip2 install --user pyflakes
fi

if [ -x "$(command -v pip3)" ]; then
    pip3 install --user pynvim
fi

if [ -x "$(command -v npm)" ]; then
    sudo npm install -g tern
fi
