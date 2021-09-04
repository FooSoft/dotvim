#!/bin/bash
git submodule update --init --recursive
pushd ./pack/plugins/opt/coc.nvim/
npm install
npm run build
popd
