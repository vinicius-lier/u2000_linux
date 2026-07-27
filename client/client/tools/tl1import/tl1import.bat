set _RUNJAVA=%IMAP_JAVA_HOME%

if not exist %_RUNJAVA%\bin\javaw.exe (
    if exist ..\..\..\..\jre\bin\javaw.exe (
        set _RUNJAVA=..\..\..\..\jre
    ) else if exist %IMAP_JAVA_HOME%\bin\javaw.exe (
        set _RUNJAVA=%IMAP_JAVA_HOME%
    ) else if exist %SystemDrive%\OSSJRE\jre_win\bin\javaw.exe (
        set _RUNJAVA=%SystemDrive%\OSSJRE\jre_win
    ) else (
        rem echo None Java Path exist
        set _RUNJAVA=""
    )
)

if %_RUNJAVA% == "" (
    echo Error: Environment IMAP_JAVA_HOME not exist.
) else (
    start  %_RUNJAVA%\bin\javaw -classpath ../../../lib/baseutil.jar;../../../lib/startup.jar;../../../lib/imapsslbase.jar;../../../lib/iview.jar;../../productlib/access/domainIndependent/access_frame.jar;../../productlib/access/domainIndependent/nemgr_frame.jar;../../../lib/3rd_tools/*; -Xms32m -Xmx640m com.huawei.n2000bms.tl1import.swing.Tl1ToolsMain
)

