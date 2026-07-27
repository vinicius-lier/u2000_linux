@echo off


setlocal

set ERRORNO=0
set CURRENT=%~dp0
set ROOT=%~d0
pushd %ROOT%
cd %CURRENT%
cd ..\..
set INSTALLROOT=%cd%

set PRIMARYINSTALLROOT=%~1%
if not "%~2"=="" set INSTALLROOT=%~2
set CAU_BAT="%PRIMARYINSTALLROOT%\cau\bin\cau.bat"

echo INSTALLROOT=%INSTALLROOT% >> %temp%\cau_update.log 2>&1
echo PRIMARYINSTALLROOT=%PRIMARYINSTALLROOT% >> %temp%\cau_update.log 2>&1
echo CAU_BAT=%CAU_BAT% >> %temp%\cau_update.log 2>&1
popd %ROOT%
if exist %CAU_BAT% (
	call %CAU_BAT% "" "%PRIMARYINSTALLROOT%" "%INSTALLROOT%" 
)else (
        echo cau is not found at %PRIMARYINSTALLROOT% location >> %temp%\cau_update.log 2>&1
    )