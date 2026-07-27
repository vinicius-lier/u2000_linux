@echo off
echo exec %0 script...
set curdir=%~dp0

set ostoolpath="%curdir%\..\..\..\engr\tools\ostools"

call %ostoolpath%\createshortcut.bat -xml "%curdir%shortcut_client.xml" -nooverwrite TRUE
