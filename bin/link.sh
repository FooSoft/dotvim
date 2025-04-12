#!/bin/bash -e

cd $(git rev-parse --show-toplevel)

if [ ! -d ~/.config/nvim ]; then
    ln -s $PWD ~/.config/nvim
fi
