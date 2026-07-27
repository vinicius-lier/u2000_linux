@echo off
set /p inp="IP Address:"
start /B putty.exe %inp%
exit