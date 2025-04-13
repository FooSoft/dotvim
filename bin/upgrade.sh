#!/bin/bash -e

pushd $(git rev-parse --show-toplevel)

git submodule update --remote --merge

popd
