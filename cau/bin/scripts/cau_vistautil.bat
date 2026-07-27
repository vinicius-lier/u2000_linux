@echo off

setlocal
set ERRORNO=0
set ERRORNUMCAU=0
set IS_INCREMENTAL_DG=false
if exist "%userprofile%"\cauutil.log (
for /f "tokens=*" %%a in ('type "%userprofile%\cauutil.log"') do (set installroot=%%a) )
del "%userprofile%"\cauutil.log >> %temp%\cau_update.log 2>&1
echo installroot=%installroot%>> %temp%\cau_update.log 2>&1
set INSTALLROOT=%installroot%>> %temp%\cau_update.log 2>&1

if exist "%allusersprofile%"\causecondaryutil.log (
for /f "tokens=*" %%a in (%allusersprofile%\causecondaryutil.log) do (set secinstallroot=%%a) )

if exist "%allusersprofile%"\cauincrdg.log (
for /f "tokens=*" %%a in (%allusersprofile%\cauincrdg.log) do (
set INCREMENTAL_DG=%%a) 
if not "%INCREMENTAL_DG%"=="" ( set IS_INCREMENTAL_DG=true)
)


echo secinstallroot=%secinstallroot%>> %temp%\cau_update.log 2>&1
echo cauincrdg=%INCREMENTAL_DG%>> %temp%\cau_update.log 2>&1

set SECONDARYROOT=%secinstallroot%>> %temp%\cau_update.log 2>&1



if not "%~1"=="" (set INSTALLROOT=%~1   )





if not "%~2"=="" set SECONDARYROOT=%~2


set _RUNJAVA=%IMAP_JAVA_HOME%\bin\java.exe
if not exist %_RUNJAVA% (
    if exist %INSTALLROOT%\uninstall\jre\jre_win\bin\java.exe (
        set _RUNJAVA=%INSTALLROOT%\uninstall\jre\jre_win\bin\java.exe
    ) else if exist %INSTALLROOT%\common\jre_win\bin\java.exe (
        set _RUNJAVA=%INSTALLROOT%\common\jre_win\bin\java.exe
    ) else if exist %INSTALLROOT%\uninstall\jre_others\jre_win\bin\java.exe (
        set _RUNJAVA=%INSTALLROOT%\uninstall\jre_others\jre_win\bin\java.exe
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
    echo ERROR! Can NOT locate java, either IMAP_JAVA_HOME not set or not a valid path >> %temp%\cau_update.log 2>&1
    echo Failed to execute the script, please check the script log at below location for error details:
    echo %temp%\cau_update.log 2>&1	
    set ERRORNO=180
    set ERRORNUMCAU=MISSING
    goto ENDCAU
)
echo INSTALLROOT=%INSTALLROOT% >> %temp%\cau_update.log 2>&1
echo _RUNJAVA=%_RUNJAVA% >> %temp%\cau_update.log 2>&1
echo SECONDARYROOT=%SECONDARYROOT% >> %temp%\cau_update.log 2>&1

set withoutKote=%INSTALLROOT:~1,-1%
set CAU_RESULT_FILE="%withoutKote%\cau\cau_result_file.properties"
echo VISTA:CAU_RESULT_FILE=%CAU_RESULT_FILE% >> %temp%\cau_update.log 2>&1
echo VISTA:CAU_NO_HUP_WIN=%CAU_NO_HUP_WIN% >> %temp%\cau_update.log 2>&1
set CAU_JAR=%INSTALLROOT%\cau\lib\cau.jar
if exist %CAU_JAR% goto RUNCAU


echo Cau not installed, skip updating resource. >> %temp%\cau_update.log 2>&1
set ERRORNUMCAU=MISSING
goto ENDCAU

:RUNCAU
    cd /d "%INSTALLROOT%"
	
    if "%IS_INCREMENTAL_DG%"=="true" goto _INCDGCALL
    if not %SECONDARYROOT%=="" goto _EXECMULTICLIENT

	echo CAU is now updating resource, please wait...
	echo CAU is now updating resource, please wait... >>%temp%\cau_update.log 2>&1
    
    call %_RUNJAVA% -Xmx512m -Dfile.encoding="UTF-8" -Djava.library.path=%INSTALLROOT%\cau\lib\ -cp %CAU_JAR% com.swimap.cmf.cau.resource.UpdateFrame %INSTALLROOT% >> %temp%\cau_update.log 2>&1
    set ERRORNUMCAU=%ERRORLEVEL%
	echo upgrade finised and result is %ERRORLEVEL% >>%temp%\cau_update.log 2>&1
    goto ENDCAU
    
    :_EXECMULTICLIENT
	echo CAU is now updating resource, please wait...
    echo CAU is now updating resource, please wait... >>%temp%\cau_update.log 2>&1
    call %_RUNJAVA% -Xmx512m -Dfile.encoding="UTF-8" -Djava.library.path=%INSTALLROOT%\cau\lib\ -cp %CAU_JAR% com.swimap.cmf.cau.resource.UpdateFrame %INSTALLROOT% %SECONDARYROOT%>> %temp%\cau_update.log 2>&1
    set ERRORNUMCAU=%ERRORLEVEL%
	echo upgrade finised and result is %ERRORLEVEL% >>%temp%\cau_update.log 2>&1
    goto ENDCAU

    :_INCDGCALL
	echo CAU is now updating only input resource, please wait...
    echo CAU is now updating only input resource, please wait... >%temp%\cau_update.log 2>&1
    call %_RUNJAVA% -Xmx512m -Dfile.encoding="UTF-8" -Djava.library.path="%INSTALLROOT%"\cau\lib\ -cp %CAU_JAR% com.swimap.cmf.cau.resource.IncrementalUpgradeResource "%INSTALLROOT%" "%INCREMENTAL_DG%" >> %temp%\cau_update.log 2>&1
    set ERRORNUMCAU=%ERRORLEVEL%
	echo upgrade finised and result is %ERRORLEVEL% >>%temp%\cau_update.log 2>&1
    goto ENDCAU

:ENDCAU
echo writing result to result file >>%temp%\cau_update.log 2>&1
echo CAU_EXIT_CODE=%ERRORNUMCAU% >%CAU_RESULT_FILE% 2>&1
if not exist %CAU_RESULT_FILE% (
echo result file is not created >> %temp%\cau_update.log 2>&1
) else (
 echo result file created >> %temp%\cau_update.log 2>&1
)
echo ERRORNUMCAU=%ERRORNUMCAU% >> %temp%\cau_update.log 2>&1
if %ERRORNUMCAU% == 0 (
EVENTCREATE /T INFORMATION /ID 1000 /D "CAU; Successful; 127.0.0.1 Data Generator finished." >> %temp%\cau_update.log 2>&1
) else (
EVENTCREATE /T INFORMATION /ID 1000 /D "CAU; Failed; 127.0.0.1 Data Generator finished." >> %temp%\cau_update.log 2>&1
)
if not "%ERRORNUMCAU%"=="0" (
    echo Failed to execute the script, please check the script log at below location for error details:
    echo 1. %temp%\cau_update.log
    if not "%ERRORNUMCAU%"=="MISSING" echo 2. %allusersprofile%\.cau\log
) else (
   echo Script is executed successfully.
)
del /Q "%temp%\cau_vistautil_temp.bat"
endlocal
exit /B %ERRORNO%



