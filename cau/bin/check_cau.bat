@echo off

set CURRENT=%~dp0
set ROOT=%~d0
pushd %ROOT%
cd %CURRENT%
set LOG_LOCATION=%tmp%/cau_checkscript_update.log


cd ../..
set CAU_INSTALL_ROOT=%CD%
echo CAU_INSTALL_ROOT=%CAU_INSTALL_ROOT% >> %LOG_LOCATION% 2>&1

set CAU_RESULT_FILE="%CAU_INSTALL_ROOT%\cau\cau_result_file.properties"
echo CAU_RESULT_FILE=%CAU_RESULT_FILE% >> %LOG_LOCATION% 2>&1


if not "%~1"=="" (
    set waitToTime=%~1
    ) else (
        set waitToTime=10
    )
echo waitToTime=%waitToTime% >> %LOG_LOCATION% 2>&1



set _RUNJAVA="%IMAP_JAVA_HOME%\bin\java.exe"
if not exist %_RUNJAVA% (
    if exist "%CAU_INSTALL_ROOT%\uninstall\jre\jre_win\bin\java.exe" (
        set _RUNJAVA="%CAU_INSTALL_ROOT%\uninstall\jre\jre_win\bin\java.exe"
    ) else if exist "%CAU_INSTALL_ROOT%\common\jre_win\bin\java.exe" (
        set _RUNJAVA="%CAU_INSTALL_ROOT%\common\jre_win\bin\java.exe"
    ) else if exist "%CAU_INSTALL_ROOT%\uninstall\jre_others\jre_win\bin\java.exe" (
        set _RUNJAVA="%CAU_INSTALL_ROOT%\uninstall\jre_others\jre_win\bin\java.exe"
    ) else (
        set _RUNJAVA="%CAU_INSTALL_ROOT%\client\jre\bin\java.exe"
    )
)

if not exist %_RUNJAVA% (
     set _RUNJAVA="%CAU_INSTALL_ROOT%\jre\bin\java.exe"
     )

if not exist %_RUNJAVA% (
     set _RUNJAVA="%CAU_INSTALL_ROOT%\cau\jre\bin\java.exe"
     )

if not exist %_RUNJAVA% (
    echo ERROR:Can't locate java.exe >> %LOG_LOCATION% 2>&1
    exit 180
)
echo using RUNJAVA=%_RUNJAVA% >> %LOG_LOCATION% 2>&1

set CAU_JAR="%CAU_INSTALL_ROOT%\cau\lib\cau.jar"
echo "CAU_JAR=%CAU_JAR%" >> %LOG_LOCATION% 2>&1


if not exist %CAU_RESULT_FILE% (
    echo "file does not exist, wait for scipt completion" >> %LOG_LOCATION% 2>&1

       
    if not exist %CAU_JAR% (
        echo "ERROR:cau does not exist,cannot wait to finish." >> %LOG_LOCATION% 2>&1
        exit 180
    ) else (
        echo "started waiting..." >> %LOG_LOCATION% 2>&1
        call %_RUNJAVA% -Dfile.encoding="UTF-8" -Djava.library.path="%CAU_INSTALL_ROOT%"\cau\lib\ -cp %CAU_JAR% com.swimap.cmf.cau.resource.ScriptWait %waitToTime% %CAU_RESULT_FILE% >> %LOG_LOCATION% 2>&1
        echo "finished waiting." >> %LOG_LOCATION% 2>&1
    )
    
    if not exist "%CAU_RESULT_FILE%" (
        echo "file still does not exist, timeout" >> %LOG_LOCATION% 2>&1
        exit 160
    ) else (
        echo "file exist after wait exiting now." >> %LOG_LOCATION% 2>&1
       
	    goto :READ_PROP
    )

) else (
    echo "file exist,script run finished already, exiting now." >> %LOG_LOCATION% 2>&1
   
    goto :READ_PROP
    
)

:READ_PROP
FOR /F "eol=; tokens=2,2 delims==" %%i IN ('findstr /i "CAU_EXIT_CODE" %CAU_RESULT_FILE%') DO set cauResult=%%i 
if "%cauResult%"=="0" (
    echo SuccessCauRes=%cauResult%
    ) else if "%cauResult%"=="" (
        echo error reading properties file.
        set cauResult=180
        echo ErrCauRes=%cauResult%
    ) else (
        echo ErrCauRes=%cauResult%
    )
echo cauResult=%cauResult% >> %LOG_LOCATION% 2>&1
popd %ROOT%
exit %cauResult%



