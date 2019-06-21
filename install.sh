#!/bin/bash

git submodule update --init --recursive
pip2 install --user pyflakes
pip3 install --user pynvim
