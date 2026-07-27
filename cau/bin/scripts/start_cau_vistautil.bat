@echo off

setlocal
set ERRORNO=0
set LOG_FILE=%temp%\cau_start.log
if exist "%allusersprofile%"\cauinstallutil.log (
for /f "tokens=*" %%a in (%allusersprofile%\cauinstallutil.log) do (set installroot=%%a) )

set INSTALLROOT=%installroot%>> %LOG_FILE% 2>&1

if exist "%allusersprofile%"\caurestartutil.log (
for /f "tokens=*" %%b in (%allusersprofile%\caurestartutil.log) do (set restartscript=%%b) )
set RESTARTSCRIPT=%restartscript%>> %LOG_FILE% 2>&1



set CAU_JAR="%INSTALLROOT%\cau\lib\cau.jar"
echo %INSTALLROOT% >> %LOG_FILE% 2>&1 
if not exist %CAU_JAR% (
    echo ERROR! %CAU_JAR% Install root does not exists >> %LOG_FILE% 2>&1
    set ERRORNO=2
    goto end
    )

set _RUNJAVA="%INSTALLROOT%\uninstall\jre\jre_win\bin\java.exe"
if not exist %_RUNJAVA% (
    if exist "%INSTALLROOT%\common\jre_win\bin\java.exe" (
        set _RUNJAVA="%INSTALLROOT%\common\jre_win\bin\java.exe"
    ) else if exist "%INSTALLROOT%\uninstall\jre_others\jre_win\bin\java.exe" (
        set _RUNJAVA="%INSTALLROOT%\uninstall\jre_others\jre_win\bin\java.exe"
    ) else (
        set _RUNJAVA="%INSTALLROOT%\client\jre\bin\java.exe"
    )
)

if not exist %_RUNJAVA% (
     set _RUNJAVA="%INSTALLROOT%\jre\bin\java.exe"
     )

if not exist %_RUNJAVA% (
     set _RUNJAVA="%INSTALLROOT%\cau\jre\bin\java.exe"
     )
     
if not exist %_RUNJAVA% (
    echo ERROR! Can't locate java.exe >> %LOG_FILE% 2>&1
    set ERRORNO=1
    goto end
)

echo INSTALLROOT=%INSTALLROOT% >> %LOG_FILE% 2>&1
echo _RUNJAVA=%_RUNJAVA% >> %LOG_FILE% 2>&1

if exist %CAU_JAR% (
    echo ss = %_RUNJAVA% -Xmx512m -Dfile.encoding="UTF-8" -Djava.library.path="%INSTALLROOT%"\cau\lib\ -cp %CAU_JAR% com.swimap.cmf.cau.UpgradeClient  %1 %2 "%INSTALLROOT%" %3 "%RESTARTSCRIPT%" >> %LOG_FILE% 2>&1
    call %_RUNJAVA% -Xmx512m -Dfile.encoding="UTF-8" -Djava.library.path="%INSTALLROOT%"\cau\lib\ -cp %CAU_JAR% com.swimap.cmf.cau.UpgradeClient %1 %2 "%INSTALLROOT%" %3 "%RESTARTSCRIPT%" >> %LOG_FILE% 2>&1
    
)

:end
del /Q "%temp%\start_cau_vistautil_temp.bat"
endlocal
exit /b %ERRORNO%
