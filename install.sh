#!/bin/bash

git submodule update --init --recursive
pip install --user pyflakes --upgrade
pip install --user pynvim --upgrade
