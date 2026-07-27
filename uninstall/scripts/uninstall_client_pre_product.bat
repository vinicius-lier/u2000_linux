@echo off

set uninstallRoot=%~dp0

pushd %uninstallRoot%


call ../../client/client/bin/UnRegisterJqs.bat


popd

exit /B 0