@echo off
mklink "%USERPROFILE%\_vimrc" "%CD%\init.vim"
mklink "%USERPROFILE%\_gvimrc" "%CD%\gvim.vim"
mklink /J "%USERPROFILE%\vimfiles" "%CD%"
