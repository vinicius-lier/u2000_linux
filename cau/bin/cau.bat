@echo off
EVENTCREATE /T INFORMATION /ID 1000 /D "CAU; Successful; 127.0.0.1 Data Generator started." >> %temp%\cau_update.log 2>&1
echo START CAU %DATE% %TIME% >> %temp%\cau_update.log 2>&1
setlocal
set ERRORNO=0
set ERRORNUMCAU=0
set CURRENT=%~dp0
set ROOT=%~d0
pushd %ROOT%
cd %CURRENT%
cd ..\..
set INSTALLROOT=%cd%

set IS_INCREMENTAL_DG=false
set BUSINESSTYPE=yes

if not "%~1"=="" (

if "%~1"=="-files" (
	set INCREMENTAL_DG=%~1
	set IS_INCREMENTAL_DG=true
   ) else (
	set INSTALLROOT=%~1
   )
) 
if not "%~2"=="" (
	if not "%IS_INCREMENTAL_DG%"=="true" (
		set IS_INCREMENTAL_DG=false
		set INSTALLROOT=%~1
		if "%~2"=="-files" (
		set INCREMENTAL_DG=%~2
		set IS_INCREMENTAL_DG=true
		) else (
		set SECONDARYROOT=%~2
		)
	)	
) 
if not "%~3"=="" (    
	set INCREMENTAL_DG=%~3
	set IS_INCREMENTAL_DG=true
)

if "%IS_INCREMENTAL_DG%"=="true" (

	setlocal enableextensions ENABLEDELAYEDEXPANSION
	set OUT=$
	set FLAG=false
	for %%x in (%*) do (
	  if !FLAG!==0 (
		
		if !OUT!==$ (
			
			set OUT=%%x
			echo Reached !OUT! >> %temp%\cau_update.log 2>&1
		) else (
			
			set OUT=!OUT!:%%x
			echo Reached !OUT! >> %temp%\cau_update.log 2>&1
		)		
	  ) else if "%%x"=="-files" (
		set "FLAG=0"
	  )

	)
	set INCREMENTAL_DG=files-!OUT!
)

set INSTALL_SCOPE_FILE="%INSTALLROOT%\engr\deploy\conf\installscope.ini"
if exist %INSTALL_SCOPE_FILE% (

	for /f "tokens=1,2 delims==" %%a in (%INSTALL_SCOPE_FILE%) do (
			if %%a == BUSINESS_TYPE (
			set BUSINESSTYPE=%%b
			echo BUSINESSTYPE %BUSINESSTYPE% >> %temp%\cau_update.log 2>&1			
		)
	)
)

echo BUSINESSTYPE=%BUSINESSTYPE% >> %temp%\cau_update.log 2>&1
echo INSTALLROOT=%INSTALLROOT% >> %temp%\cau_update.log 2>&1
echo INCREMENTAL_DG=%INCREMENTAL_DG% >> %temp%\cau_update.log 2>&1



echo cau run condition BUSINESSTYPE=%BUSINESSTYPE% >> %temp%\cau_update.log 2>&1
set CAU_CFG_FILE="%INSTALLROOT%\cau\bin\businessType.cfg"
echo CAU_CFG_FILE=%CAU_CFG_FILE% >> %temp%\cau_update.log 2>&1
 
if not exist %CAU_CFG_FILE% (
    echo Continue cau as cfg file does not exist:%CAU_CFG_FILE% >> %temp%\cau_update.log 2>&1
) else if "%BUSINESSTYPE%"=="" ( 
    echo Continue cau as BUSINESSTYPE=%BUSINESSTYPE% >> %temp%\cau_update.log 2>&1
    goto :NORMAL
    ) else (
        echo to do business check >> %temp%\cau_update.log 2>&1
        goto :BUSINESSTYPECHECK
    )
    
:BUSINESSTYPECHECK
set XCAU_CFG_FILE=%INSTALLROOT%\cau\bin\businessType.cfg
FOR /F "usebackq tokens=1* delims==" %%A IN ( "%XCAU_CFG_FILE%" ) DO ( 
echo attr %%A %%B %BUSINESSTYPE%>> %temp%\cau_update.log 2>&1
IF %BUSINESSTYPE% == %%A (
SET businessCondition=%%B
)
)
echo businessCondition %businessCondition% >> %temp%\cau_update.log 2>&1
if "%businessCondition%" == "no" (
    echo Exiting cau as businessCondition=%businessCondition% >> %temp%\cau_update.log 2>&1
    endlocal
    exit /B 0
    ) else (
        echo Continue cau as businessCondition=%businessCondition% >> %temp%\cau_update.log 2>&1        
    )

:NORMAL

set CAU_RESULT_FILE="%INSTALLROOT%\cau\cau_result_file.properties"
echo CAU_RESULT_FILE=%CAU_RESULT_FILE% >> %temp%\cau_update.log 2>&1
echo CAU_NO_HUP_WIN=%CAU_NO_HUP_WIN% >> %temp%\cau_update.log 2>&1

ver | %SystemRoot%\system32\FIND /C " 5."  >> %temp%\cau_update.log 2>&1
if "%ERRORLEVEL%" == "0" (
	set IS_VISTA=5
	goto :_XP
) else (
	set IS_VISTA=6
)
echo IS_VISTA=%IS_VISTA% >> %temp%\cau_update.log 2>&1

echo Re-Launching script as administrator, Please click allow or continue button from the following prompt to continue
@set _INSTALL="%INSTALLROOT%\cau\bin\scripts\run.vbs"
@set _INSTALL1="%INSTALLROOT%\cau\bin\scripts\cau_vistautil.bat"
copy /Y %_INSTALL1% "%temp%\cau_vistautil_temp.bat" >nul 2>&1
@set _INSTALL1_TEMP="%temp%\cau_vistautil_temp.bat"
del "%userprofile%"\cauutil.log >nul 2>&1
echo "%INSTALLROOT%"> "%userprofile%"\cauutil.log
del "%allusersprofile%"\causecondaryutil.log >nul 2>&1
echo "%SECONDARYROOT%"> "%allusersprofile%"\causecondaryutil.log

del "%allusersprofile%"\cauincrdg.log >nul 2>&1
echo "%INCREMENTAL_DG%"> "%allusersprofile%"\cauincrdg.log

start wscript //nologo %_INSTALL% %_INSTALL1_TEMP%

endlocal
exit %ERRORNO%
:_XP

set _RUNJAVA="%IMAP_JAVA_HOME%\bin\java.exe"
if not exist %_RUNJAVA% (
    if exist "%INSTALLROOT%\uninstall\jre\jre_win\bin\java.exe" (
        set _RUNJAVA="%INSTALLROOT%\uninstall\jre\jre_win\bin\java.exe"
    ) else if exist "%INSTALLROOT%\common\jre_win\bin\java.exe" (
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
    echo ERROR! Can NOT locate java, either IMAP_JAVA_HOME not set or not a valid path >> %temp%\cau_update.log 2>&1
    echo Failed to execute the script, please check the script log at below location for error details:
    echo %temp%\cau_update.log 2>&1	
    set ERRORNO=180
    set ERRORNUMCAU=MISSING
    goto end
)

echo INSTALLROOT=%INSTALLROOT% >> %temp%\cau_update.log 2>&1
echo _RUNJAVA=%_RUNJAVA% >> %temp%\cau_update.log 2>&1
echo SECONDARYROOT=%SECONDARYROOT% >> %temp%\cau_update.log 2>&1

set CAU_JAR="%INSTALLROOT%\cau\lib\cau.jar"

if exist %CAU_JAR% goto RUNCAU


echo Cau not installed, skip updating resource. >> %temp%\cau_update.log 2>&1
set ERRORNUMCAU=MISSING
goto end

:RUNCAU
    
	
	if "%IS_INCREMENTAL_DG%"=="true" goto :_INCDGCALL
    if not "%SECONDARYROOT%"=="" goto :_EXECMULTICLIENT

    echo CAU is now updating resource, please wait...
   
    call %_RUNJAVA% -Xmx512m -Dfile.encoding="UTF-8" -Djava.library.path="%INSTALLROOT%"\cau\lib\ -cp %CAU_JAR% com.swimap.cmf.cau.resource.UpdateFrame "%INSTALLROOT%" >> %temp%\cau_update.log 2>&1
    set ERRORNUMCAU=%ERRORLEVEL%
    goto end
    
    :_EXECMULTICLIENT
    echo CAU is now updating resource, please wait...
   
    call %_RUNJAVA% -Xmx512m -Dfile.encoding="UTF-8" -Djava.library.path="%INSTALLROOT%"\cau\lib\ -cp %CAU_JAR% com.swimap.cmf.cau.resource.UpdateFrame "%INSTALLROOT%" "%SECONDARYROOT%">> %temp%\cau_update.log 2>&1
    set ERRORNUMCAU=%ERRORLEVEL%
    goto end

    :_INCDGCALL
      echo CAU is now updating only input resource, please wait...
     
    call %_RUNJAVA% -Xmx512m -Dfile.encoding="UTF-8" -Djava.library.path="%INSTALLROOT%"\cau\lib\ -cp %CAU_JAR% com.swimap.cmf.cau.resource.IncrementalUpgradeResource "%INSTALLROOT%" "%INCREMENTAL_DG%" >> %temp%\cau_update.log 2>&1
    set ERRORNUMCAU=%ERRORLEVEL%
    goto end


:end
popd %ROOT%
echo IS_VISTA=%IS_VISTA% >> %temp%\cau_update.log 2>&1
if %IS_VISTA% == 6 (
	endlocal
	exit %ERRORNO%
)

echo CAU_EXIT_CODE=%ERRORNUMCAU% > %CAU_RESULT_FILE%

echo ERRORNUMCAU=%ERRORNUMCAU% >> %temp%\cau_update.log 2>&1
if not "%ERRORNUMCAU%"=="0" (
    echo Failed to execute the script, please check the script log at below location for error details:
    echo 1. %temp%\cau_update.log
    if not "%ERRORNUMCAU%"=="MISSING" echo 2. %allusersprofile%\.cau\log
) else (
    echo Script is executed successfully.
)
if "%CAU_NO_HUP_WIN%" == ""0"" (
    endlocal
	exit %ERRORNO%
) else (
	endlocal
	exit /B %ERRORNO%
)


