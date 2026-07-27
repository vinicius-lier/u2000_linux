@echo off
set IMAP_ROOT=%~dp0\..\..\server
IF EXIST %IMAP_ROOT%\platform\bin\script\businessoperatelog.bat (
   CALL %IMAP_ROOT%\platform\bin\script\businessoperatelog.bat "[stopU2000.bat] Start stopU2000.bat successful!" information > NUL 2>&1
)
if not exist "%IMAP_ROOT%\tools\optimize\bin\GetOSVersion_i.exe" (
	CALL %IMAP_ROOT%\platform\bin\script\businessoperatelog.bat "[stopU2000.bat] Failed stopU2000.bat!" error > NUL 2>&1
   exit /B
) else (
  for /F "tokens=1,2,3,4,5,*" %%a in ('"%IMAP_ROOT%\tools\optimize\bin\GetOSVersion_i.exe"') do (
	if %%e' == 1' goto versionmatchstart
   )
   CALL %IMAP_ROOT%\platform\bin\script\businessoperatelog.bat "[stopU2000.bat] Failed stopU2000.bat!" error > NUL 2>&1
   exit /B
)
:versionmatchstart

cd /d %IMAP_ROOT%\platform\bin\
call stopnms.bat
CALL %IMAP_ROOT%\platform\bin\script\businessoperatelog.bat "[stopU2000.bat] Successful stopU2000.bat!" information > NUL 2>&1