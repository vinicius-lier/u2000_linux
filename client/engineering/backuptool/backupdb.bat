
@echo off
Setlocal EnableDelayedExpansion
@set _LOCATION = %~dp0
@set WD=%~dp0..\..\..
@set SCRIPTPATH=%~f0
:: count the parameters 
set /a count = 3
IF "%3"=="" ( set /a count =2 )
 

set pypath=!WD!\server\3rdTools\python
set pycmd=python
if exist !pypath! (	
	set PYTHONHOME=
	set PATH=!pypath!\lib;!PATH!
	set pycmd=!WD!\server\3rdTools\python\bin\python
	set PATH=!PATH!;!WD!\engr\engineering\lib\windows
)

SET CURRENTDIR=%~dp0
CD /D !CURRENTDIR!

for /f "delims==" %%i in ('!pycmd! -c "import sys;print(str(sys.version_info[0])+str(sys.version_info[1]))"') do ( 
		set  check=%%i
		)

 IF "!check!" == "27" (
	set PYTHONPATH=%PYTHONPATH%;%WD%\engr\tools\common;%WD%\engr\tools\common\xmltool\windows;%WD%\engr\tools\dbtools\DBoperation;%WD%
        
      IF !count! LSS 3  ( 
         echo "" |!pycmd! bin\app.pyc %* backupdb 
      
      ) ELSE ( 
	     set /p stdin=
	     echo !stdin!|!pycmd! bin\app.pyc %* backupdb 
	 )


 ) ELSE (

 exit /B 85

 )

exit /B %errorlevel%
