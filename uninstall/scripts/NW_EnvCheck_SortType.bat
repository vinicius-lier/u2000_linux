@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

rem 变量检测
if "%1"==""    goto invalidPara_1
if "%2"==""    goto invalidPara_2
if "%3"==""    goto invalidPara_3
if "%4"==""    goto invalidPara_3
set INSTALLROOT=%~4

rem 先删除临时日志
SET tmplog=%tmp%\sp_helpsort.log
if exist %tmplog% (
	echo remove the sp_helpsort log
	del %tmplog%
)

rem 数据库查询脚本
SET checksql=%INSTALLROOT%\engr\install\scripts\sql\sp_helpsort.sql
if not exist %checksql% (
	echo Error: the chcek sql %checksql% is not exist"
	exit 4
)

rem 开始检查，由于之前的一个页面已经包含了用户名，密码和实例名的检测，不需要考虑密码合法性
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

type %tmplog% | %systemroot%\system32\find /I "binary sort"
if !ERRORLEVEL! == 1  goto err

goto eof

:invalidPara_1
echo The database Administrator username should not be null.
exit 1

:invalidPara_2
echo The database Administrator password should not be null.
exit 2

:invalidPara_3
echo The database instance should not be null.
exit 3

:err
echo Error: the database sort type is not "binary sort", please uninstall the database server manually.
exit 5

:eof
echo Correct: the database server sort type is binary sort.
exit 0

