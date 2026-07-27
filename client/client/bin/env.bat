@REM Save current direcotry. 
set CURRENT_DIR=%CD%

@REM Change Directory to relative JRE directory
cd ..\..\..

set JAVA_HOME_DIR=%CD%\jre

@REM Use relative JRE directory
if exist "%JAVA_HOME_DIR%" goto end

@REM Use IMAP_JAVA_HOME
if exist "%IMAP_JAVA_HOME%" (
    set JAVA_HOME_DIR=%IMAP_JAVA_HOME%
    goto end
)

@REM Use C:/OSSJRE/jre_win
if exist "C:/OSSJRE/jre_win" (
    set JAVA_HOME_DIR=C:/OSSJRE/jre_win
    goto end
)

@REM Give an error message when no JRE found
echo "Warning: no jre found in current dir, IMAP_JAVA_HOME and C:/OSSJRE/jre_win."
goto quit

:end
@REM Set both path and IMAP_JAVA_HOME variable 
set path=%JAVA_HOME_DIR%\bin;..\script\lib\core\itf;..\lib\dll;%path%
set IMAP_JAVA_HOME=%JAVA_HOME_DIR%

:quit
@REM Change to saved directory
cd "%CURRENT_DIR%"