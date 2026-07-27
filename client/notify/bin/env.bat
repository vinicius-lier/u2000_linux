@REM Save current direcotry
set CURRENT_DIR="%CD%"

@REM Change Directory to relative JRE directory
cd ..\..\..

set JAVA_HOME_DIR="%CD%\jre"

@REM Change to saved directory
cd %CURRENT_DIR%

if not exist %JAVA_HOME_DIR% if not "%IMAP_JAVA_HOME%"=="" set JAVA_HOME_DIR="%IMAP_JAVA_HOME%"

if not exist %JAVA_HOME_DIR% set JAVA_HOME_DIR=C:/OSSJRE/jre_win

@REM Give an error message when no JRE found
if not exist %JAVA_HOME_DIR% echo "Warning: no jre found in current dir, IMAP_JAVA_HOME and C:/OSSJRE/jre_win."

@REM Set both path and IMAP_JAVA_HOME variable 
set path=%JAVA_HOME_DIR%\bin;%path%
set IMAP_JAVA_HOME=%JAVA_HOME_DIR%