@echo off

pushd "%~dp0"
powershell.exe -ExecutionPolicy Unrestricted ./%~n0.ps1
popd
