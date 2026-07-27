@echo off

echo exec %0 script...
@set _DIR=%~dp0
set PYTHONHOME=
set pypath=%_DIR%\..\..\..\server\3rdTools\python
set oldPath=%PATH%
SET PATH=%PATH%;%pypath%\lib
set pycmd=%pypath%\bin\python.exe
set scriptPath=%_DIR%\modifdbdescriptionfile.pyc
%pycmd% %scriptPath% %~1 2>&1
set PATH=%oldPath%
