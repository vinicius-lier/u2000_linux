echo off
setlocal enabledelayedexpansion

set file=..\..\notify\locale.properties

if exist "%file%" (
   for /f "delims="  %%a in ('type "%file%"') do  (
       set str=%%a
       if "!str!"=="" (
       echo !str!>>"%file%".bak
       )else (
          set "str=!str:@{INSLANGUAGE}=%1!"
          echo !str!>>"%file%".bak
       )
   )
   move /y "%file%".bak "%file%"
)else (
   echo "Warning: no language file locale.properties found."
)