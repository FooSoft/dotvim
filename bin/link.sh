#!/bin/bash -e

pushd $(git rev-parse --show-toplevel)

if [ ! -d ~/.config/nvim ]; then
    ln -s $PWD ~/.config/nvim
fi

popd
