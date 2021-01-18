@echo off
mklink "%USERPROFILE%\_vimrc" "%CD%\.vimrc"
mklink "%USERPROFILE%\_gvimrc" "%CD%\.gvimrc"
mklink /J "%USERPROFILE%\vimfiles" "%CD%\.vim"
