#!/bin/bash
if [ ! -d ~/.config/nvim ]; then
    ln -s $PWD ~/.config/nvim
fi
