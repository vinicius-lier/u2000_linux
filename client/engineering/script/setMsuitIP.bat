@echo off
cd /D %~dp0
set ClientRoot=%~dp0..\..\..
echo ClientRoot is :%ClientRoot% > %temp%\setMsuiteIP.log 2>&1

set cauInterfacefile="%ClientRoot%\cau\config\CauInterface.properties"
if not exist %cauInterfacefile% (
  echo "/cau/config/CauInterface.properties  is not exist,exit" >> %temp%\setMsuiteIP.log 2>&1
  goto end
)
set MsuiteLoginfile="%ClientRoot%\client\engineering\conf\msuite\loginIPHistory.cfg"
if not exist %MsuiteLoginfile% (
  echo "client\engineering\conf\msuite\loginIPHistory.cfg  is not exist,exit" >> %temp%\setMsuiteIP.log 2>&1
  goto end
)
for /f "tokens=1,* delims==" %%a in ('find "customServerName="^<"%ClientRoot%\cau\config\CauInterface.properties"') do (
set a=%%b&&goto:a)
:a
SET serverip1=%a%
for /f "tokens=*" %%i in ("%serverip1%") do set serverip2=%%~nxi
echo server ip is : ---%serverip2%--- >> %temp%\setMsuiteIP.log 2>&1

set IP1=SERVER_IP1=%serverip2%

echo get the target info is:%IP1% >> %temp%\setMsuiteIP.log 2>&1

set TempFile="%temp%\ServerIPList_tmp.cfg"
cd.>%TempFile%
FOR /F "usebackq tokens=1,2* delims== " %%i IN (%MsuiteLoginfile%) DO (
    set str=%%i
    if "%%i"=="SERVER_IP1" (
    echo %IP1% >>%TempFile% 
    )else (
    echo %%i=%%j >>%TempFile%
    )
)

set BackupFile="%temp%\ServerIPList_bak.cfg"
copy "%MsuiteLoginfile%" "%BackupFile%" >nul 2>&1
move /Y %TempFile% %MsuiteLoginfile% >nul 2>&1

: end
echo End: %time% >> %temp%\setMsuiteIP.log 2>&1