@echo off
set CAU_NO_HUP_WIN="0"
set LOG_PATH="%temp%\cau_nohup_update.log"
set CURRENT=%~dp0
set ROOT=%~d0
pushd %ROOT%
cd %CURRENT%
start /B wrap_cau.bat
popd %ROOT%
