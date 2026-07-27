@echo off

rem ODBC optimization
echo "start excute reg_modify.bat"
rem Modify 64-bit and 32-bit data sources to 127.0.0.1
%systemroot%\System32\reg.exe add HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\ODBC\ODBC.INI\DBSVR /f /v Server /t REG_SZ /d 127.0.0.1 
%systemroot%\System32\reg.exe add HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\DBSVR /f /v Server /t REG_SZ /d 127.0.0.1


rem Modify the database client to 127.0.0.1
%systemroot%\System32\reg.exe add HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\MSSQLServer\Client\ConnectTo /f /v 127.0.0.1 /t REG_SZ /d DBMSSOCN,127.0.0.1,1433 
%systemroot%\System32\reg.exe add HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\MSSQLServer\Client\ConnectTo /f /v DBSVR /t REG_SZ /d DBMSSOCN,127.0.0.1,1433 
%systemroot%\System32\reg.exe add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSSQLServer\Client\ConnectTo /f /v 127.0.0.1 /t REG_SZ /d DBMSSOCN,127.0.0.1,1433 
%systemroot%\System32\reg.exe add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSSQLServer\Client\ConnectTo /f /v DBSVR /t REG_SZ /d DBMSSOCN,127.0.0.1,1433 
echo "excute reg_modify end"

