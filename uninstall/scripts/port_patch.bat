@echo off

echo exec %0 script...
rem 判断当前系统是否xp和win2003
ver | %SystemRoot%\system32\FIND /C " 5." > NUL
if "%ERRORLEVEL%" == "0" goto _xp

exit 0

:_xp
set currentDIR=%~dp0
%systemroot%\regedit.exe /s %currentDIR%port_patch.reg

exit 0
