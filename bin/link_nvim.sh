#!/bin/bash
pushd $PWD/..
if [ ! -d ~/.config/nvim ]; then
    ln -s $PWD ~/.config/nvim
fi
popd
