@echo off

if "%IMAP_ROOT%"=="" (
    echo IMAP_ROOT environment variable is not set, script will exit!
    goto :END
)
set INSTALLROOT=%IMAP_ROOT%
set TOMCATWORKCAUDIR=%INSTALLROOT%\3rdTools\tomcat\work\Catalina\localhost\cau
echo deleting cau folder in tomcat work folder
RD /S /Q %TOMCATWORKCAUDIR%
echo Ensure that tomcat is restarted before using CAU.
exit /B 0
:END
 echo Script removeTomcatWorkCau.bat is not started, set IMAP_ROOT environment variable and try again!