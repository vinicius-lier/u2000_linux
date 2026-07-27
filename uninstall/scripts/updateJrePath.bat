@echo off
echo "update jre start..." >>%temp%/updatejre.log
set PYTHONHOME=
set PYTHONPATH=
set ossroot=%1
set pypath=%ossroot%\server\3rdTools\python
set oldPath=%PATH%
SET PATH=%PATH%;%pypath%\lib
set pycmd=%pypath%\bin\python.exe
%pycmd% %ossroot%\engr\install\scripts\updateJrePath.pyc %*
set PATH=%oldPath%
echo "update jre end...">>%temp%/updatejre.log