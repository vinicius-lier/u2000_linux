echo off
set installRoot=%~dp0
pushd %installRoot%
setlocal enabledelayedexpansion

set resfile=..\..\..\engr\deploy\conf\macros.ini

if exist "%resfile%" (
    for /f "delims== tokens=2" %%i in ('findstr "INSLANGUAGE" "%resfile%"') do (
        set INSLANGUAGE=%%i
    )
    if "!INSLANGUAGE!"=="" (
        echo "string not found"
    )else (
        call installscripts_imapsf.bat !INSLANGUAGE!
        call installscripts_imapfm.bat !INSLANGUAGE!
    )
)else (
    echo "file not found"
)

cd %installRoot%