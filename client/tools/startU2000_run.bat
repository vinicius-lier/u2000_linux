@echo off
set OSS_ROOT=%~dp0\..\..
set IMAP_ROOT=%OSS_ROOT%\server
IF EXIST %IMAP_ROOT%\platform\bin\script\businessoperatelog.bat (
   CALL %IMAP_ROOT%\platform\bin\script\businessoperatelog.bat "[startU2000.bat] Start startU2000.bat successful!" information > NUL 2>&1
)
if not exist "%OSS_ROOT%\server\tools\optimize\bin\GetOSVersion_i.exe" (
	CALL %IMAP_ROOT%\platform\bin\script\businessoperatelog.bat "[startU2000.bat] Failed startU2000.bat!" error > NUL 2>&1
   exit /B
) else (
  for /F "tokens=1,2,3,4,5,*" %%a in ('"%OSS_ROOT%\server\tools\optimize\bin\GetOSVersion_i.exe"') do (
	if %%e' == 1' goto versionmatchstart
   )
   CALL %IMAP_ROOT%\platform\bin\script\businessoperatelog.bat "[startU2000.bat] Failed startU2000.bat!" error > NUL 2>&1
   exit /B
)
:versionmatchstart

start %OSS_ROOT%\OSSJRE\jre_win\bin\javaw -classpath jdom.jar;DomainCtrlClient.jar com.huawei.exectool.MainFrame
CALL %IMAP_ROOT%\platform\bin\script\businessoperatelog.bat "[startU2000.bat] Successful startU2000.bat!" information > NUL 2>&1