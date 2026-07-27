@echo off
REM 1. check %IMAP_JAVA_HOME%
REM 2. check ..\jre
REM 3. check C:\OSSJRE\jre_win 
REM 4. None exist, Exit with error infomation

REM  CR20120203031  Puttyconf
set puttyreg=HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions\Default^%%20Settings

REM 避免每次启动脚本都把查询出来的内容打印到屏幕
if exist %SystemRoot%\system32\reg.exe (
%SystemRoot%\system32\reg.exe query %puttyreg% /s >.\puttyregresult.txt
if errorlevel 1 (
	echo "The system not reg MouseIsXterm"
	%SystemRoot%\system32\reg.exe import puttyconf.reg
)  else (
   for /f "tokens=1,2,3" %%i in ('%SystemRoot%\system32\reg.exe query %puttyreg% /s ^|findstr MouseIsXterm') do (
      IF not "X%%k"=="X0x2" (
	    echo "The MouseIsXterm value is error"
	    %SystemRoot%\system32\reg.exe import puttyconf.reg
     )	
   )
)
)

exit