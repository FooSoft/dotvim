#!/bin/sh

# YouCompleteMe
pushd ./bundle/YouCompleteMe
git submodule update --init --recursive
./install.py
popd

# tern_for_vim
pushd ./bundle/tern_for_vim
sudo npm install -g tern
npm install
popd

# syntastic
sudo npm -g install eslint
sudo pip install pyflakes
