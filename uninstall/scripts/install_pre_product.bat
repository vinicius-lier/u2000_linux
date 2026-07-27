echo off
rem 从工程平台将下面装.NETFramework代码移过来
%systemroot%\system32\reg.exe QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v3.0" > nul 2>&1
if "%ERRORLEVEL%" == "1" (
	if exist %systemroot%\System32\ServerManagerCmd.exe (
		start /B %systemroot%\System32\ServerManagerCmd.exe -install NET-Framework -allSubFeatures >nul 2>&1
	)
)