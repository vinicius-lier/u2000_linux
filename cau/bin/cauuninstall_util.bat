@echo off
set "uninstallroot="
if exist "%userprofile%\cauuninstall.log" (
	for /f "tokens=*" %%a in ('type "%userprofile%\cauuninstall.log"') do (
		set "uninstallroot=%%~a"
	)
)
for /f "useback tokens=*" %%a in ('"%uninstallroot%"') do (
	set "uninstallroot=%%~a"
)
del "%userprofile%\cauuninstall.log" >nul 2>nul
pushd "%uninstallroot%" >nul 2>nul
set uninstall_vbs=uninstall.vbs
if exist %uninstall_vbs% (       
    start %uninstall_vbs%    
) else (
    echo Cau uninstall.vbs not exist,cannot uninstall. >> %temp%\cau_update.log 2>&1
)
popd