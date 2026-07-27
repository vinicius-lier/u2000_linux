@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

rem 变量检测
if "%1"==""    goto invalidPara_1
if "%2"==""    goto invalidPara_2
if "%3"==""    goto invalidPara_3
if "%4"==""    goto invalidPara_3
set INSTALLROOT=%~4
rem 先删除临时日志
SET tmplog=%tmp%\sp_version.log
SET tmpverlog=%tmp%\osver.log
SET getmemorylog=%tmp%\sp_getmemory.log
if exist %tmplog% (
	echo Remove the sp_version log
	del %tmplog%
)

if exist %tmpverlog% (
	echo Remove the os version log
	del %tmpverlog%
)

if exist %getmemorylog% (
	echo Remove the sp_getmemory log
	del %getmemorylog%
)
rem 检测脚本路径
SET checksql=%INSTALLROOT%\engr\install\scripts\sql\select_product_level.sql
if not exist %checksql% (
	echo Error: the chcek sql %checksql% is not exist
	exit 4
)

rem 检查获取物理内存的命令是否可以执行
SET checksqlgetmemory=%INSTALLROOT%\engr\install\scripts\sql\sp_getmemory.sql
if not exist %checksqlgetmemory% (
	echo Error: the chcek sql %checksqlgetmemory% is not exist
	exit 4
)
rem 获取操作系统版本，根据版本号对应
%systemroot%\system32\reg.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion"  /v ProductName >%tmpverlog%

rem windows 7  和 windows 2008都使用sql 2008, windows 2003 使用sql 2000
set sqlver="SP1" "SP3" "SP4"

type %tmpverlog% | %systemroot%\system32\find /I "Windows Server 2003"
if !ERRORLEVEL! == 0 (
	echo get the os ver is Windows Server 2003
	rem sqlserver 2000包含以下2个版本
	set sqlver="SP4" "RTM"
)

type %tmpverlog% | %systemroot%\system32\find /I "Windows XP"
if !ERRORLEVEL! == 0 (
	echo get the os ver is Windows XP
	rem sqlserver 2000包含以下2个版本
	set sqlver="SP4" "RTM"
	)else (
		echo get the os ver is Windows 2008 or windows 7 or Windows 10 or Windows 2012
)
SET pypath=%INSTALLROOT%\server\3rdTools\python
SET PYTHONHOME=
SET PATH=%PATH%;%pypath%\lib
set pyscript=%INSTALLROOT%\engr\install\scripts\connectSQL.pyc
SET pycmd=%pypath%\bin\python.exe
if not exist  %pyscript% (
	echo Error: the  python script is not exist
	goto err
)

%pycmd% %pyscript% "%1" %2 "%3" %checksql% %tmplog%
if %ERRORLEVEL% == 0 (
	echo excute python script successfully
	)else (
		echo excute python script failed
		goto err		
)


%pycmd% %pyscript% "%1" %2 "%3" %checksqlgetmemory% %getmemorylog%
if %ERRORLEVEL% == 0 (
	echo excute python script successfully
	)else (
		echo excute python script failed
		goto getmemoryerr		
)

:checkversion
for  %%i in (%sqlver%) do (
	set charver=%%i
	type %tmplog% | %systemroot%\system32\find /I !charver!
	if !ERRORLEVEL! == 0 (
		echo Get the DB version is !charver!
		goto eof
	)
)

goto err

rem 参数错误
:invalidPara_1
echo The database Administrator username should no be null.
exit 1

:invalidPara_2
echo The database Administrator password should no be null.
exit 2

:invalidPara_3
echo The database instance name should no be null.
exit 3

:err
echo Error: the DB version is not support.
exit 5

:getmemoryerr
echo Error: get the PhysicalMemory failed.
exit 4

:eof
echo Correct: the DB version is support.
exit 0
