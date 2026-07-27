@echo off

set ERRORNO=0
set LOG_LOCATION="%temp%\cau_wrap_update.log"
set CURRENT=%~dp0
set ROOT=%~d0
pushd %ROOT%
cd %CURRENT%
cd ..\..
set CAU_INSTALL_ROOT=%cd%

echo CAU_INSTALL_ROOT=%CAU_INSTALL_ROOT% >> %LOG_LOCATION% 2>&1

set CAU_RESULT_FILE="%CAU_INSTALL_ROOT%\cau\cau_result_file.properties"
echo CAU_RESULT_FILE=%CAU_RESULT_FILE% >> %LOG_LOCATION% 2>&1


if exist %CAU_RESULT_FILE% (
    echo "Deleteing already existing DG output file" >> %LOG_LOCATION% 2>&1
    del %CAU_RESULT_FILE% >> %LOG_LOCATION% 2>&1
)


cd cau\bin
start /B /WAIT cau.bat
set ERRORNO=%ERRORLEVEL%
popd %ROOT%
exit %ERRORNO%




