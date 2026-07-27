@echo off
echo exec %0 script...
cd /D %~dp0
setlocal enabledelayedexpansion
rem 先删除临时日志
set tmplog=%tmp%\Application.log
set tmpverlog=%tmp%\MaxSizeLog.log
set newvar=
if exist %tmplog% (
	echo remove the application log
	del %tmplog%
)

if exist %tmpverlog% (
	echo remove the os MaxSize log
	del %tmpverlog%
)

REM 修改应用程序日志大小
%systemroot%\system32\reg.exe query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\EventLog\Application" /v "MaxSize" > %tmplog%
if %ERRORLEVEL% == 0 (
	goto first
)
:first
type %tmplog% | %systemroot%\system32\find /I "MaxSize" > %tmpverlog%
if %ERRORLEVEL% == 0 (
	set /p MString=<!tmpverlog!
	set oldvar=!MString: =!
	set newvar=!oldvar:~16!
	echo MaxSize is !newvar!. 
)
if %newvar% LSS 0x20000000 (
	%systemroot%\system32\reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\EventLog\Application" /f /v "MaxSize" /t REG_DWORD /d "0x20000000"
)
rem 修改日志达到最大值后的策略
%systemroot%\system32\reg.exe query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\EventLog\Application" /v "AutoBackupLogFiles" > nul 2>&1
if %ERRORLEVEL% == 0 (
	%systemroot%\system32\reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\EventLog\Application" /f /v "AutoBackupLogFiles" /t REG_DWORD /d "0x00000000"
)

%systemroot%\system32\reg.exe query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\EventLog\Application" /v "Retention" > nul 2>&1
if %ERRORLEVEL% == 0 (
	%systemroot%\system32\reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\EventLog\Application" /f /v "Retention" /t REG_DWORD /d "0x00000000"
)
exit /B