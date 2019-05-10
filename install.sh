#!/bin/bash

git submodule update --init --recursive
pip2 install --user pyflakes --upgrade
pip3 install --user pynvim --upgrade
