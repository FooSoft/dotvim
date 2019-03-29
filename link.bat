@echo off

mklink "%USERPROFILE%\_vimrc" "%CD%\.vimrc"
mklink /J "%USERPROFILE%\.vim" "%CD%\.vim"
