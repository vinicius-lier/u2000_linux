@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
rem 应该传入网管的安装路径
if "%1"==""    goto invalidPara_1
set INSTALLROOT=%~1
rem 先删除临时日志
SET tmpdbdevicelog=%tmp%\dbdevicepath.log
if exist %tmpdbdevicelog% (
	del %tmpdbdevicelog%
)

rem 设置python运行依赖库到环境变量
SET PYTHONPATH=
SET PYTHONHOME=
SET pypath=%INSTALLROOT%\server\3rdTools\python
SET PATH=%PATH%;%pypath%\lib
SET pycmd=%pypath%\bin\python.exe
SET pyscript=%INSTALLROOT%\engr\engineering\tool\gconftool.pyc
SET syscfg=%INSTALLROOT%\engr\install\etc\conf\sysconfigure_install.xml
SET pyargs=sysconfigure/hostInfos/hostInfo/Paths/Path

rem 从全局配置文件中获取数据库data的安装路径
%pycmd% %pyscript% --file %syscfg% --xpath %pyargs% --attri name --value DBDEVICEPATH --param PathName >%tmpdbdevicelog% 2>&1

rem 检查数据库安装目录是否在系统目录
type %tmpdbdevicelog% | %systemroot%\system32\find /I "%SystemRoot%"
if !ERRORLEVEL! == 0 (
	echo the path should not containd the %SystemRoot%
	goto patherror_1
)
rem 检查数据库安装目录是否在网管目录
type %tmpdbdevicelog% | %systemroot%\system32\find /I %1
if !ERRORLEVEL! == 0 (
	echo the path should not containd the %1
	goto patherro_2
)

goto eof

rem 参数错误
:invalidPara_1
	echo The oss install path should no be null.
	exit 1

:patherror_1
	echo the path is invalid,should not in the systemroot.
	exit 2

:patherro_2
	echo the path is invalid,should not in the oss directory.
	exit 3

:eof
	echo Correct.
	exit 0


