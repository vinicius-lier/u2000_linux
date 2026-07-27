@echo off
setlocal ENABLEDELAYEDEXPANSION

WMIC OS GET Caption | findstr Windows | findstr "2008" > NUL 2>&1
if %errorlevel% == 0 (
	for /f "tokens=2*" %%i in ('%systemroot%\system32\reg.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\TrendMicro\PC-cillinNTCorp\CurrentVersion\Misc." /v ProgramVer') do set p=%%j
	
	goto end
)

:win32
	for /f "tokens=2*" %%i in ('%systemroot%\system32\reg.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\TrendMicro\PC-cillinNTCorp\CurrentVersion\Misc." /v ProgramVer') do set p=%%j
	

:end
	echo %p% 
	exit 0
	
