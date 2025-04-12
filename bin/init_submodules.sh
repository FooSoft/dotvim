#!/bin/bash -e

cd $(git rev-parse --show-toplevel)

git submodule update --init --recursive
