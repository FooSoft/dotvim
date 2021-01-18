#!/bin/bash
pushd $PWD/..
ln -sf $PWD/init.vim ~/.vimrc
ln -sf $PWD/gvim.vim ~/.gvimrc
if [ ! -d ~/.vim ]; then
    ln -s $PWD ~/.vim
fi
popd
