@ECHO OFF
@set _DIR=%~dp0
set businesstypepath=%_DIR%\..\..\tools\getBusinessType.bat
setlocal enableDelayedExpansion

if "%1"=="--setup" (
	goto _setup
)
for /f "delims=" %%i in ('call %businesstypepath%') do set "BusinessType=%%i"

if "%1"=="--uninstall" (
	if "%BusinessType%" == "uninstall" (
		goto _uninstall
	)
	
)
goto end

:_setup
set tmplog=%tmp%\verison.log
%systemroot%\system32\reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion"  /v ProductName >%tmplog%
type %tmplog% | find "2008" >nul
if %ERRORLEVEL% == 0 (
	ECHO create schtasks dblogmonitor
	schtasks /create /f /sc minute /mo 5 /tn dblogmonitor /tr %_DIR%\dblogmonitor.vbs
	if !ERRORLEVEL! == 0 (
	    call %_DIR%\..\..\engineering\script\tools\businessoperatelog.bat "dblogmonitor.bat;successful;create the task dblogmonitor successful." information
	) else (
	    call %_DIR%\..\..\engineering\script\tools\businessoperatelog.bat "dblogmonitor.bat;failed;create the task dblogmonitor failed." error
	)
)
goto end


:_uninstall
setlocal disabledelayedexpansion
ECHO delete schtasks dblogmonitor
schtasks /delete /tn dblogmonitor /f
if %ERRORLEVEL% == 0 (
	call %_DIR%\..\..\engineering\script\tools\businessoperatelog.bat "dblogmonitor.bat;successful;delete the task dblogmonitor successful." information
) else (
	call %_DIR%\..\..\engineering\script\tools\businessoperatelog.bat "dblogmonitor.bat;failed;delete the task dblogmonitor failed." error
)
goto end

:end
@ECHO ON