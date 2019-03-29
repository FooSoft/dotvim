#!/bin/sh

git submodule foreach git pull origin master
git submodule foreach --recursive git submodule update
