@echo off
@set _DIR=%~dp0
set PYTHONHOME=
set pypath=%_DIR%\..\..\..\server\3rdTools\python
set oldPath=%PATH%
SET PATH=%PATH%;%pypath%\lib
set pycmd=%pypath%\bin\python.exe
echo "%INSTALLROOT%"
if exist %INSTALLROOT%\server\etc\conf\sysconfigure_bak.xml (
	%pycmd% %_DIR%\replaceIP.pyc "%_DIR%\..\..\.."
)
set PATH=%oldPath%