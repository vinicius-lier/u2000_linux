@echo off
set INSTALLROOT=%1%
set ERRORNO=0


set LOGLOCATION=%tmp%\cau_serviceRemoved.log
echo LOGLOCATION=%LOGLOCATION% >>%LOGLOCATION% 2>&1
echo INSTALLROOT=%INSTALLROOT% >> %LOGLOCATION% 2>&1



set CAU_SERVER=%INSTALLROOT%
if exist %INSTALLROOT%\server   (     
       set CAU_SERVER=%INSTALLROOT%\server
)
echo CAU_SERVER=%CAU_SERVER% >> %LOGLOCATION% 2>&1

cd /d %CAU_SERVER%\platform\bin  >> %LOGLOCATION% 2>&1


set TEMP_FILE= /imap/sac/services/CAUService
SettingTool %TEMP_FILE%/   >> %LOGLOCATION% 2>&1
if not "%ERRORLEVEL%"=="0" (
    echo CAUService doesn't exist,don't need to unregister CAUService
    exit 0
)

SettingTool -cmd delgroup -path %TEMP_FILE%   >> %LOGLOCATION% 2>&1
set ERRORNO=%ERRORLEVEL% 
if not "%ERRORLEVEL%"=="0" (
echo Unregister  CAUService operation failed, Exit from script with ERRORNO=%ERRORNO%  >> %LOGLOCATION% 2>&1
    exit %ERRORNO%	  
) else (
    echo Unregister  CAUService successfully done with ERRORNO=%ERRORNO% >> %LOGLOCATION% 2>&1 
)

exit  \b %ERRORNO%


