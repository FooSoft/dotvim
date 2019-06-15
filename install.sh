#!/bin/bash

git submodule update --init --recursive
pip3 install --user --no-binary :all: pynvim
