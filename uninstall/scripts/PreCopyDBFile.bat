@ECHO OFF

set OSSENGRPATH=%1
cd %~dp0

SET pypath=%OSSENGRPATH%\server\3rdTools\python
SET scrPath=servertype.pyc
SET xmlpath=DBSizeDynamicConfig.xml

SETLOCAL DISABLEDELAYEDEXPANSION

SET PYTHONHOME=
SET PATH=%PATH%;%pypath%\lib
SET pycmd=%pypath%\bin\python.exe

%pycmd% %scrPath% %xmlpath% >%tmp%\dbsizetype.log 2>&1
set /p dbsz=<%tmp%\dbsizetype.log
SET install_cfg=%OSSENGRPATH%\install_info.cfg
echo dbsize=%dbsz%>%install_cfg%

if exist %tmp%\servertype.log (
    del /f %tmp%\servertype.log
  )

%pycmd% %scrPath% %xmlpath% 2>%tmp%\servertype.log
