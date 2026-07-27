@echo off
setlocal ENABLEDELAYEDEXPANSION

rem 先删除临时日志
SET tmplog=%tmp%\envpath.log
SET tmpverlog=%tmp%\osver.log
if exist %tmplog% (
	echo remove the envpath log
	del %tmplog%
)

if exist %tmpverlog% (
	echo remove the os version log
	del %tmpverlog%
)

rem 获取当前的path路径
%systemroot%\system32\reg.exe query "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Environment" /v Path >%tmplog%

rem 获取操作系统版本，根据版本号对应
%systemroot%\system32\reg.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion"  /v ProductName >%tmpverlog%
type %tmpverlog% | %systemroot%\system32\find /I "Windows Server 2008"
if !ERRORLEVEL! == 0 (
	echo get the os ver is Windows Server 2008
	rem 数据库包含的路径，windows场景下只能安装到系统盘
	set sqlpath="100\Tools\Binn" "100\DTS\Binn" "100\Tools\Binn\VSShell\Common7\IDE"
	goto checkpath
)

type %tmpverlog% | %systemroot%\system32\find /I "Windows 10"
if !ERRORLEVEL! == 0 (
	echo get the os ver is windows 10
	set sqlpath="100\Tools\Binn" "100\DTS\Binn"
	goto checkpath
)

type %tmpverlog% | %systemroot%\system32\find /I "Windows 7"
if !ERRORLEVEL! == 0 (
	echo get the os ver is windows 7
	set sqlpath="100\Tools\Binn" "100\DTS\Binn"
	goto checkpath
)

type %tmpverlog% | %systemroot%\system32\find /I "Windows Server 2003"
if !ERRORLEVEL! == 0 (
	echo get the os ver is Windows Server 2003
	set sqlpath="Microsoft SQL Server\80\Tools\BINN"
)

type %tmpverlog% | %systemroot%\system32\find /I "Windows XP"
if !ERRORLEVEL! == 0 (
	echo get the os ver is Windows XP
	set sqlpath="Microsoft SQL Server\80\Tools\BINN"
)

type %tmpverlog% | %systemroot%\system32\find /I "Windows Server 2012"
if !ERRORLEVEL! == 0 (
	echo get the os ver is Windows Server 2012
	set sqlpath="100\Tools\Binn" "100\DTS\Binn"
	goto checkpath
)

:checkpath
for  %%i in (%sqlpath%) do (
	set envpath=%%i
	echo Check the path !envpath!
	type %tmplog% | %systemroot%\system32\find /I !envpath! >nul
	if !ERRORLEVEL! == 1 (
		echo The path not all exist !envpath!
		goto err
	)
)

goto eof

:err
echo Error: path not exist.
exit 2

:eof
echo Correct: the pathes all exist.
exit 0
