#!/bin/bash
git submodule update --init --recursive
pushd pack/plugins/start/telescope-fzf-native.nvim
make
popd
