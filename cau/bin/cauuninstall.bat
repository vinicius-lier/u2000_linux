@echo off

setlocal
set ERRORNO=0
cd ..\..
set INSTALLROOT=%cd%
if not "%~1"=="" set INSTALLROOT=%~1

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
    echo ERROR! Can't locate java.exe >> %temp%\cau_update.log 2>&1
    set ERRORNO=180
    goto end
)
echo INSTALLROOT=%INSTALLROOT% >> %temp%\cau_update.log 2>&1
echo _RUNJAVA=%_RUNJAVA% >> %temp%\cau_update.log 2>&1

set CAU_JAR="%INSTALLROOT%\cau\lib\cau.jar"
if exist %CAU_JAR% (
    echo CAU is now updating resource, please wait...
    
    call %_RUNJAVA% -Xmx512m -Dfile.encoding="UTF-8" -Djava.library.path="%INSTALLROOT%"\cau\lib\ -cp %CAU_JAR% com.swimap.cmf.cau.uninstall.UninstallComponent "%INSTALLROOT%" >> %temp%\cau_update.log 2>&1
    echo Done.
) else (
    echo Cau not installed, skip updating resource. >> %temp%\cau_update.log 2>&1
   ERRORNO=0
)

:end
endlocal
exit /b %ERRORNO%

