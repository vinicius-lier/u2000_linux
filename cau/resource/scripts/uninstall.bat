@echo off
set CURRENT=%~dp0
set ROOT=%~d0
pushd %ROOT%
cd %CURRENT%
cd ..
cd cau/bin
set "UNINSTALLROOT=%cd%"
echo Re-Launching script as administrator, Please click allow or continue button from the following prompt to continue
@set _INSTALL="%cd%\scripts\run.vbs"
copy /Y "%cd%\cauuninstall_util.bat" "%temp%\cauuninstall_uil_temp.bat" >nul 2>&1
@set _INSTALL_TEMP="%temp%\cauuninstall_uil_temp.bat"
echo "%UNINSTALLROOT%"> "%userprofile%\cauuninstall.log"
start wscript //nologo %_INSTALL% %_INSTALL_TEMP%
popd %ROOT%
:end
