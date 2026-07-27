@echo off

cd /d %~dp0

REM cd client\client directory
cd client

set _RUNJAVA=%IMAP_JAVA_HOME%

if not exist ..\..\jre\bin\javaw.exe (
    if exist %_RUNJAVA%\bin\javaw.exe (
        REM echo ..\jre\bin\javaw.exe Exist
        set _RUNJAVA=%IMAP_JAVA_HOME%
    ) else if exist ..\..\OSSJRE\jre_win\bin\javaw.exe (
        REM echo ..\OSSJRE\jre_win\bin\javaw.exe Exist
        set _RUNJAVA=..\..\OSSJRE\jre_win
    ) else (
        REM echo None Java Path exist
        set _RUNJAVA=""
    )
) else (
   set _RUNJAVA=..\..\jre
)

if %_RUNJAVA% == "" (
    echo Error: Environment IMAP_JAVA_HOME not exist.
) else (
    REM echo Successed!
    start /min %_RUNJAVA%\bin\javaw -Dprocname=sysmonitor -classpath .\startuploader.jar -Dnet.sf.ehcache.skipUpdateCheck=true -XX:MinHeapFreeRatio=10 -XX:MaxHeapFreeRatio=40 -XX:NewRatio=12 -XX:MaxNewSize=32m -Xms8m -Xmx64m -Xverify:none -Dserialize=false -Dparsertype=2 -XX:MetaspaceSize=6m -XX:MaxMetaspaceSize=64m  -XX:CompressedClassSpaceSize=32m  -Dsun.java2d.noddraw=true -Dhelpapp=run_help.bat -Dsubsystem=sysmonitor -Dimap.isOpenSystemMonitorFrame=true -Djava.library.path=..\..\cau\lib;.\update\lib;..\lib -XX:+HeapDumpOnOutOfMemoryError -Dorg.omg.CORBA.ORBSingletonClass=org.openorb.CORBA.ORBSingleton -DExtesnionRigestry.debug=false -DLoginHandler=com.swimap.iview.systemmonitor.login.SysMonitorLoginHandler -Dsm.serverinfosrc=MonitorModule -Dsm.defaultport=31030 -Dsm.defaultsslport=31080 -DExtesionRegistry.cacheUse=false -Dscript.name="%~fp0" -Dfile.encoding=UTF-8 com.swimap.startup.Startup -debuglevel 1 -showtrace false -enabledebug false -tracefile DebugTrace.txt %*
)


