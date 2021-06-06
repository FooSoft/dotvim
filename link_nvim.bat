@echo off
pushd "%CD%\.."
mklink /J "%LOCALAPPDATA%\nvim" "%CD%"
popd