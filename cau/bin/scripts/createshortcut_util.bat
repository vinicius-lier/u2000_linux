@echo off
set "CAU_SHORTCUT_LOG=%temp%\cau_shortcut.log"
echo %DATE% %TIME% shortcut creation  is started... >> "%CAU_SHORTCUT_LOG%" 2>&1
call :addWindowsEventLog INFORMATION "Shortcut creation started." "Successful" >> "%CAU_SHORTCUT_LOG%" 2>&1
set "INSTALLROOT="
if not exist "%allusersprofile%\.cau\dll" (
	md "%allusersprofile%\.cau\dll" >nul 2>nul
)
REM if OS is Windows Server (R) 2008 Enterprise without Hyper-V skip the chcp 65001
set OS_REG_KEY="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
set win8="no"
for /F "tokens=1,2*" %%a in ('reg query %OS_REG_KEY% /v "ProductName" ^| %SystemRoot%\system32\findstr /c:"Windows Server (R) 2008 Enterprise without Hyper-V"') do (
	set win8="yes"
	)
"chcp 65001" >nul 2>nul
for /f "tokens=2,3* delims=:." %%a in ('chcp') do (
		set "ACTIVEPAGE=%%~a"
	)
set ACTIVEPAGE=%ACTIVEPAGE: =%
if not %ACTIVEPAGE%==65001 (
	if %win8%=="no" (
	chcp 65001 >nul 2>nul
	 ) 
)
if exist "%userprofile%\create_shortcut_env.log" (
	for /f "tokens=*" %%a in ('type "%userprofile%\create_shortcut_env.log"') do (
		set "INSTALLROOT=%%~a"
	)
)
for /f "useback tokens=*" %%a in ('"%INSTALLROOT%"') do (
set "INSTALLROOT=%%~a"
)
del "%userprofile%\create_shortcut_env.log" >nul 2>nul
set "clang="
set key_2="HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\CodePage"
	for /F "tokens=3" %%a in ('reg query %key_2% /v "OEMCP"') do (
	set "clang=%%a"
	)
"chcp %clang%" >nul 2>nul
for /f "tokens=2,3* delims=:." %%a in ('chcp') do (
		set "ACTIVEPAGE=%%~a"
	)
set ACTIVEPAGE=%ACTIVEPAGE: =%
if %ACTIVEPAGE%==65001 (
	chcp %clang% >nul 2>nul
)
set INSTALLROOT=%INSTALLROOT:"=%
pushd "%INSTALLROOT%" >nul 2>nul
set "_RUNJAVA=%INSTALLROOT%\jre\bin\java.exe"

set "INSTALLINFO_DIR=%INSTALLROOT%\cau\installinfo\windows"
set "INSTALLINFO_WIN=cau\installinfo\windows"
set "SHORTCUT_DIR=%INSTALLROOT%\uninstall\shortcuts"
set "SHORT_PROP=%SHORTCUT_DIR%\shortcut.properties"

echo INSTALLROOT=%INSTALLROOT% >> "%CAU_SHORTCUT_LOG%" 2>&1
echo SHORTCUT_DIR=%SHORTCUT_DIR% >> "%CAU_SHORTCUT_LOG%" 2>&1
echo _RUNJAVA=%_RUNJAVA% >> "%CAU_SHORTCUT_LOG%" 2>&1

if not exist "%_RUNJAVA%" (
    echo ERROR! Can't locate java.exe >> "%CAU_SHORTCUT_LOG%" 2>&1
	echo shortcut creation is failed >> "%CAU_SHORTCUT_LOG%" 2>&1
	call :addWindowsEventLog INFORMATION "Shortcut creation is stopped." "Stopped"
    set ERRORNO=180
    goto end
)
	if not exist "%SHORTCUT_DIR%" (
		mkdir "%SHORTCUT_DIR%" >> "%CAU_SHORTCUT_LOG%" 2>&1
	)
	
set "CAU_JAR=%INSTALLROOT%\cau\lib\cau.jar"
if not exist "%CAU_JAR%" (
 echo ERROR! client compressing not done properly  >> "%CAU_SHORTCUT_LOG%" 2>&1
 echo shortcut creation is failed >> "%CAU_SHORTCUT_LOG%" 2>&1
 call :addWindowsEventLog INFORMATION "Shortcut creation is stopped." "Stopped"
    set ERRORNO=180
    goto end
)
if not exist "%INSTALLINFO_DIR%" (
	echo ERROR! installinfo information not exist ,so shortcuts are not created  >> "%CAU_SHORTCUT_LOG%" 2>&1
	echo shortcut creation is failed >> "%CAU_SHORTCUT_LOG%" 2>&1
	call :addWindowsEventLog INFORMATION "Shortcut creation is stopped." "Stopped"
	set ERRORNO=160
    goto end
	)
if  exist "%SHORT_PROP%" (
 echo shortcuts already created for this client,please check .dat files in "%SHORTCUT_DIR%" >> "%CAU_SHORTCUT_LOG%" 2>&1
 echo shortcut creation is finished successfully>> "%CAU_SHORTCUT_LOG%" 2>&1
 call :addWindowsEventLog INFORMATION "Shortcut creation is finished." "Successful"
 call "%INSTALLROOT%/cau/bin/cau.bat" >> "%CAU_SHORTCUT_LOG%" 2>&1
 goto end
)
call :getCurrentsystemLang
set user_language=EN
	if "%cLanguage%"=="CHS" (
	set user_language=ZH
	)
echo creating shortcut please wait...
xcopy /Y  "%INSTALLROOT%\cau\lib\*.dll"  "%allusersprofile%\.cau\dll" >> "%CAU_SHORTCUT_LOG%" 2>&1
pushd "%INSTALLROOT%/cau/lib"
  call "%_RUNJAVA%"  -Xmx512m -Dfile.encoding="UTF-8" -Duser.language=%user_language% -cp "cau.jar" com.swimap.cmf.cau.shortcut.GreenClientShortcut "createshortcut" "%INSTALLINFO_WIN%" >> "%CAU_SHORTCUT_LOG%" 2>&1
  
  if "%errorlevel%"=="0" (
  echo shortcut=done>"%SHORT_PROP%" 2>&1
  echo shortcut creation finished successfully >> "%CAU_SHORTCUT_LOG%" 2>&1
  call :addWindowsEventLog INFORMATION "Shortcut creation is finished." "Successful"
  ) else (
  echo shortcut creation failed because root and parent folders are not configured >> "%CAU_SHORTCUT_LOG%" 2>&1
  call :addWindowsEventLog INFORMATION "Shortcut creation is stopped." "Stopped"
  )
popd
  rmdir "%allusersprofile%\.cau\dll" /S /Q >> "%CAU_SHORTCUT_LOG%" 2>&1
  call "%INSTALLROOT%/cau/bin/cau.bat" >> "%CAU_SHORTCUT_LOG%" 2>&1
goto :EOF

:getCurrentsystemLang
	set Key="HKEY_CURRENT_USER\Control Panel\International"
	for /F "tokens=3" %%a in ('reg query %Key%  ^| %SystemRoot%\system32\findstr /i "sLang"') do (
	set "cLanguage=%%a"
	) 
	set key_2="HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\CodePage"
	for /F "tokens=3" %%a in ('reg query %key_2%  ^| %SystemRoot%\system32\find /i "OEMCP"') do (
	if not %%a==936 (
	set "cLanguage=ENU"
	)
	)
	goto :EOF
REM Log level can be ERROR|WARNING|INFORMATION|SUCCESSAUDIT|FAILUREAUDIT
:addWindowsEventLog
	EVENTCREATE /T %1 /L APPLICATION /ID 100 /D "Create shortcut;%~3;127.0.0.1; %~2" > nul 2> nul
	exit /b 0
:end
exit /b %ERRORNO%
