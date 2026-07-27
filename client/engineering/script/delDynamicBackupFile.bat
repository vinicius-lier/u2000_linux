@echo off
cd /D %~dp0
set ClientRoot=%~dp0..\..\..\uninstall
cd /d %ClientRoot% 2>nul
if %ERRORLEVEL% == 1 goto HASERROR
set uninstallDir=%CD%
echo uninstallDir is :%uninstallDir% > %temp%\uninstallDir.log 2>nul
for /f %%i in ('dir /a/b ^|findstr "^DynamicFileBackup.*$"') do (
	echo %%i >>%temp%\uninstallDir.log
	rd /s /q %%i
)
cd /D %~dp0
exit /B 0
:HASERROR
exit /B 1