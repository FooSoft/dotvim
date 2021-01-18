#!/bin/bash
git submodule update --init --recursive
if [ -x "$(command -v pip3)" ]; then
    pip3 install --user pynvim
    pip3 install --user python-language-server
fi
