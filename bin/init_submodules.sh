#!/bin/bash -e

pushd $(git rev-parse --show-toplevel)

git submodule update --init --recursive

popd
