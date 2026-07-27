@echo off
setlocal ENABLEDELAYEDEXPANSION

set dbName=%1
set saPasswd=%2
set installType=%3
set adminUser=%4
echo %installType% >>%temp%\silent.log
if %installType% NEQ "install" (
	exit 0	
)
@set _DIR=%~dp0
echo %_DIR%
CALL %_DIR%..\..\engineering\script\tools\businessoperatelog.bat "Sqlserverpatch;Successful start patch." information > NUL 2>&1
set SoftWareLibStorage=%_DIR%..\..\engineering\conf\SoftWareLibStorage.cfg
echo %SoftWareLibStorage% >>%temp%\silent.log

set /p instPath=<%SoftWareLibStorage%
echo %instPath% >>%temp%\silent.log 
rem "get os version"
set tmplog=%temp%\verison.log
%systemroot%\system32\reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion"  /v ProductName >%tmplog% 
type %tmplog% | findstr /C:"Windows 7" >null
if %ERRORLEVEL% == 0 (
	echo "Windows_7" >>%temp%\silent.log 	
	set dbpath=%instPath%\patch\sql2008
	echo %dbpath% >>%temp%\silent.log
	if  not exist !dbpath! (
		echo "The OS of Windows 7 has no database patch for now" >>%temp%\silent.log
		exit 0
	)
)
type %tmplog% | findstr /C:"Windows 10" >null
if %ERRORLEVEL% == 0 (
	echo "Windows_10" >>%temp%\silent.log
	set dbpath=%instPath%\patch\sql2008
	echo %dbpath% >>%temp%\silent.log
	if  not exist !dbpath! (
		echo "The OS of Windows 10 has no database patch for now" >>%temp%\silent.log
		exit 0
		pause
	)
)
type %tmplog% | find "2003" >null
if %ERRORLEVEL% == 0 (
	echo "Windows_2003" >>%temp%\silent.log 
	set dbpath=%instPath%\patch\sql2000
	echo %dbpath% >>%temp%\silent.log
	exit 0
) else (
	echo "Windows_2008" >>%temp%\silent.log 
	set dbpath=%instPath%\patch\sql2008	
	echo %dbpath% >>%temp%\silent.log 
)
echo select @@version >checkDbVersion.sql
set tmplog=%temp%\dbverison.log
isql -S%dbName% -U%adminUser% -P%saPasswd% -icheckDbVersion.sql > %tmplog%
del checkDbVersion.sql
type %tmplog% | find "10.0.5512.0" >null
if %ERRORLEVEL% == 0 (
	echo "dbpatch is exist!" >>%temp%\silent.log
    CALL %_DIR%..\..\engineering\script\tools\businessoperatelog.bat "Sqlserverpatch;dbpatch exists;skip install patch." information > NUL 2>&1	

) else (
	echo "dbpatch is not exist!" >>%temp%\silent.log 
	if  exist %dbpath% (
		cd /d %dbpath%
		for /r %%a in (*KB*.exe) do (
			echo installing patch %%a >>%temp%\silent.log 
			start /B /wait %%a /quiet /action=Patch /instancename=MSSQLSERVER
		)
		for /r %%b in (*KB*.exe) do (
			echo installing patch %%b>>%temp%\silent.log 
			start /B /wait %%b /quiet /action=Patch /instancename=MSSQLSERVER
		)
		echo install successful >>%temp%\silent.log
		CALL %_DIR%..\..\engineering\script\tools\businessoperatelog.bat "Sqlserverpatch;Successful install patch." information > NUL 2>&1
		echo "Finished to install the sql patch files."  >>%temp%\silent.log 
	) else (
		echo %dbpath% not exist!, exit! >>%temp%\silent.log 
		exit 1
	)
)






