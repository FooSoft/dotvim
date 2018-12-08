#!/bin/bash

# YouCompleteMe
pushd .vim/bundle/YouCompleteMe
git submodule update --init --recursive
./install.py --clang-completer
popd

# tern_for_vim
pushd .vim/bundle/tern_for_vim
sudo npm install -g tern
npm install
popd

# syntastic
sudo npm -g install eslint
pip install --user pyflakes --upgrade
