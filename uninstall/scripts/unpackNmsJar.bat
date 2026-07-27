@echo off
set ossroot=%1
echo "unpack nms jar start...." >>%ossroot%/engr/install/scripts/unpackNmsJar.log
set PYTHONHOME=
set PYTHONPATH=
set pypath=%ossroot%\server\3rdTools\python
set oldPath=%PATH%
SET PATH=%PATH%;%pypath%\lib
set pycmd=%pypath%\bin\python.exe
%pycmd% %ossroot%\engr\install\scripts\unpackNmsJar.pyc %* >>%ossroot%/engr/install/scripts/unpackNmsJar.log
set PATH=%oldPath%
echo "unpack nms jar end...">>%ossroot%/engr/install/scripts/unpackNmsJar.log