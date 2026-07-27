@echo off
setlocal ENABLEDELAYEDEXPANSION

SET tmpverlog=%tmp%\osver.log
if exist %tmpverlog% (
	echo remove the os version log
	del %tmpverlog%
)

rem 获取当前的path路径
%systemroot%\system32\reg.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\TrendMicro\PC-cillinNTCorp\CurrentVersion\Misc." >%tmpverlog%
type %tmpverlog% | %systemroot%\system32\find /I "ProgramVer"
if not !ERRORLEVEL! == 0 (
	exit 21
)
exit 20
