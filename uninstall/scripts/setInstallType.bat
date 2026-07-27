@echo off

echo exec %0 script...
SET OSSENGRROOT=%~dp0..\..
rem 生成的类型文件engineering\conf\config\MsuiteStatusBarExtInfo.cfg
SET installInfo=%OSSENGRROOT%\engineering\conf\config\MsuiteStatusBarExtInfo.cfg
rem windows直接设置成单机
echo Single >%installInfo%

rem 判断当前系统是否xp和win2003
ver | %SystemRoot%\system32\FIND /C " 5." > NUL
if "%ERRORLEVEL%" == "0" goto _xp

exit 0

:_xp
%systemroot%\regedit.exe /s %OSSENGRROOT%\install\scripts\port_patch.reg

exit 0
