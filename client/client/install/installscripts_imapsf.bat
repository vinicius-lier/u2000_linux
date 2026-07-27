echo off
setlocal enabledelayedexpansion

set sfile=..\..\script\locale.properties
set cfile=..\..\client\locale.properties

if exist "%sfile%" (
    for /f "delims="  %%a in ('type "%sfile%"') do  (
        set str=%%a
        if "!str!"=="" (
            echo !str!>>"%sfile%".bak
        )else (
        set "str=!str:@{INSLANGUAGE}=%1!"
            echo !str!>>"%sfile%".bak
        )
    )
    move /y "%sfile%".bak "%sfile%"
)else (
    echo "Warning: no language file locale.properties found."
)

if exist "%cfile%" (
    for /f "delims="  %%a in ('type "%cfile%"') do  (
        set str=%%a
        if "!str!"=="" (
            echo !str!>>"%cfile%".bak
        )else (
        set "str=!str:@{INSLANGUAGE}=%1!"
            echo !str!>>"%cfile%".bak
        )
    )
    move /y "%cfile%".bak "%cfile%"
)else (
    echo "Warning: no language file locale.properties found."
)