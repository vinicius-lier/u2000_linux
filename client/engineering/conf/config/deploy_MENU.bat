@echo off

rem 获取安装类型和网管安装路径
set installtype= %~1
set installPath= %~2


rem 获取系统版本
set tmplog=%tmp%\verison.log
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion"  /v ProductName >%tmplog% 

type %tmplog% | find "Windows 7"

if %ERRORLEVEL% == 0 (
	echo "The system is Windows 7"
	goto copycfg
)else (
goto xp	
)

:xp
type %tmplog% | find "Windows XP"
	if %ERRORLEVEL% == 0 (
	echo "The system is Windows XP"
	goto copycfg
	)
exit 0
:copycfg
rem 获取工程目录
	IF "%OSSENGRROOT%"=="" SET OSSENGRROOT=C:\OSSENGR
	rem 定制前台部署菜单定制文件
	if exist %installPath%\client\engineering\conf\config (
		if not exist %installPath%\client\engineering\conf\config\DeployMenuStatus.cfg_back (
			if exist %installPath%\client\engineering\conf\config\DeployMenuStatus.cfg (
				copy %installPath%\client\engineering\conf\config\DeployMenuStatus.cfg  %installPath%\client\engineering\conf\config\DeployMenuStatus.cfg_back /y
		)
	)
	copy %OSSENGRROOT%\engineering\conf\config\DeployMenuStatus_MENU.cfg  %installPath%\client\engineering\conf\config\DeployMenuStatus.cfg
)

