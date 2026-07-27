@echo off

rem ******************************************************************************
rem 定制维护工具支持配置扩展IP

SET InstallRoot=%1
set pypath=%InstallRoot%\server\3rdTools\python
set pycmd=%pypath%\bin\python.exe
%pycmd% %InstallRoot%\engr\install\scripts\OssuserPermission.pyc > NUL 2>&1
echo "excute OssuserPermission.bat success"