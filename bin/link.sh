#!/bin/bash -e

pushd "$(git rev-parse --show-toplevel)"

mkdir -p ~/.config
if [ ! -e ~/.config/nvim ] && [ ! -L ~/.config/nvim ]; then
    ln -s "$PWD" ~/.config/nvim
fi

popd
