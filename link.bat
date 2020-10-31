@echo off

mklink "%USERPROFILE%\_vimrc" "%CD%\.vimrc"
mklink /J "%USERPROFILE%\vimfiles" "%CD%\.vim"
