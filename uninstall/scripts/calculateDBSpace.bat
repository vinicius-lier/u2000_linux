@echo off

echo exec %0 script...
@set _DIR=%~dp0
set pypath=%_DIR%\..\..\..\server\3rdTools\python
SET PYTHONHOME=
set oldPath=%PATH%
SET PATH=%PATH%;%pypath%\lib
set pycmd=%pypath%\bin\python.exe

set pyscript=%_DIR%\calculateDBSpace.pyc
if not exist  %pyscript% (
	echo Error: the  python script "%pyscript%" is not exist
	goto err
)
%pycmd% %pyscript% "%~1" 2>&1
set PATH=%oldPath%
if %ERRORLEVEL% == 0 (
	echo Calculate DB space successfully.
	goto eof
)

goto err
:err
echo Error: Calculate DB space failed.
exit /B 2

:eof
exit /B 0