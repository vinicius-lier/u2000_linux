@echo off

cd /d %~dp0

cd client\bin
if exist env.bat (
	call env.bat
	cd ..
	cd ..
)


REM cd client\client directory
cd client

set _RUNJAVA=%IMAP_JAVA_HOME%

IF EXIST oldpath.properties (
    FOR /F "delims== tokens=1,2" %%I IN (oldpath.properties) do (
        IF "%%I"=="oldPath" (
            IF NOT %%J == "%~dp0" (
                IF NOT %%J == "%~dp0 " (
                    REM echo "Fix dir have been changed, remove configuration dir."
                    IF EXIST configuration (
		    RMDIR /S /Q configuration
		    )
                    echo oldPath="%~dp0"> oldpath.properties
                )
            )
        )
    )
) ELSE (
    REM echo "Fix dir have been changed, remove configuration dir."
	IF EXIST configuration (
        RMDIR /S /Q configuration
	)
    echo oldPath="%~dp0"> oldpath.properties
)

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
    start /min %_RUNJAVA%\bin\javaw -Dprocname=client -Dfile.encoding=UTF-8 -classpath .\startuploader.jar -Dnet.sf.ehcache.skipUpdateCheck=true -Xverify:none -Dparsertype=2 -Xms128m -Xmx600m -XX:+UseSerialGC -XX:MaxMetaspaceSize=600m -XX:CompressedClassSpaceSize=300m -XX:MaxHeapFreeRatio=40 -XX:MinHeapFreeRatio=25 -XX:NewRatio=12 -XX:MaxNewSize=32m -DloadJarExtPaths=false -Dexsubsystem=cmdclient -Dsun.java2d.noddraw=true -Dhelpapp=run_help.bat -XX:+HeapDumpOnOutOfMemoryError -Dserialize=false -DSingleFileChooserPath=true -DskipObjFileCheck=true -Djava.library.path=..\..\cau\lib;.\update\lib;..\lib;..\script\lib\core\itf -DExtesnionRigestry.debug=false -Dpatchtime=true -DExtesionRegistry.cacheUse=true -Dscript.name="%~fp0"  -DSpecification.Verify=true com.swimap.startup.Startup -debuglevel 1 -showtrace false -enabledebug true -tracefile DebugTrace.txt %*
)


