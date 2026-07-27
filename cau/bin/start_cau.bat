@echo off

setlocal
set ERRORNO=0
set INSTALLROOT=%3
set INSTALLROOT=%INSTALLROOT:\=\\%
set RESTARTSCRIPT=%5
set RESTARTSCRIPT=%RESTARTSCRIPT:\=\\%
set LOG_FILE=%temp%\cau_start.log

@set _INSTALL="%~dp0"scripts\run.vbs
@set _INSTALL1="%~dp0"scripts\start_cau_vistautil.bat
copy /Y "%_INSTALL1%" "%temp%\start_cau_vistautil_temp.bat"
@set _INSTALL1_TEMP="%temp%\start_cau_vistautil_temp.bat"


ver | %SystemRoot%\system32\FIND /C " 5."  >> %LOG_FILE% 2>&1
if "%ERRORLEVEL%" == "0" goto :_XP
set INSTALLROOT=%INSTALLROOT:"=%
set RESTARTSCRIPT=%RESTARTSCRIPT:"=%
del "%allusersprofile%"\cauinstallutil.log >nul 2>&1
echo %INSTALLROOT%> "%allusersprofile%"\cauinstallutil.log

if not "%RESTARTSCRIPT%" == "" goto isnotEmpty
del "%allusersprofile%"\caurestartutil.log >nul 2>&1
goto isEmpty

:isnotEmpty
del "%allusersprofile%"\caurestartutil.log >nul 2>&1
echo %RESTARTSCRIPT%> "%allusersprofile%"\caurestartutil.log

:isEmpty
echo Re-Launching script as administrator, Please click allow or continue button from the following prompt to continue
start wscript //nologo %_INSTALL% %_INSTALL1_TEMP% %1 %2 %4

goto :end

:_XP

set CAU_JAR=%INSTALLROOT%\cau\lib\cau.jar
if not exist %CAU_JAR% (
    echo ERROR! Install root does not exists >> %LOG_FILE% 2>&1
    set ERRORNO=2
    goto end
    )

set _RUNJAVA=%INSTALLROOT%\uninstall\jre\jre_win\bin\java.exe
if not exist %_RUNJAVA% (
    if exist %INSTALLROOT%\common\jre_win\bin\java.exe (
        set _RUNJAVA=%INSTALLROOT%\common\jre_win\bin\java.exe
    ) else (
        set _RUNJAVA=%INSTALLROOT%\client\jre\bin\java.exe
    )
)

if not exist %_RUNJAVA% (
     set _RUNJAVA=%INSTALLROOT%\jre\bin\java.exe
     )

if not exist %_RUNJAVA% (
     set _RUNJAVA=%INSTALLROOT%\cau\jre\bin\java.exe
     )
     
if not exist %_RUNJAVA% (
    echo ERROR! Can't locate java.exe >> %LOG_FILE% 2>&1
    set ERRORNO=1
    goto end
)

echo INSTALLROOT=%INSTALLROOT% >> %LOG_FILE% 2>&1
echo _RUNJAVA=%_RUNJAVA% >> %LOG_FILE% 2>&1

if exist %CAU_JAR% (
   
    call %_RUNJAVA% -Xmx512m -Dfile.encoding="UTF-8" -Djava.library.path=%INSTALLROOT%\cau\lib\ -cp %CAU_JAR% com.swimap.cmf.cau.UpgradeClient %1 %2 %INSTALLROOT% %4 %RESTARTSCRIPT% >> %LOG_FILE% 2>&1
)

:end
endlocal
exit /b %ERRORNO%
