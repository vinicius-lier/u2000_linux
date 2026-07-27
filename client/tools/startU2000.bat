@echo off
set current=%~dp0
cd /d %current%
sc qc iMapService | %systemroot%\System32\findstr DEMAND_START > NUL
if not %errorlevel% == 0 goto set_demand
sc qc NodeMgr | %systemroot%\System32\findstr DEMAND_START > NUL
if not %errorlevel% == 0 goto set_demand

call startU2000_run.bat > NUL
goto :EOF


:set_demand
rem 便携机将网管进程改为手动启动
sc config NodeMgr start= demand > NUL
sc config iMapService start= demand > NUL