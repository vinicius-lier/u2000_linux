set ClientRoot="%~dp0..\..\.."
echo ClientRoot is :%ClientRoot% > "%temp%"\cau_install.log 2>&1

if not exist %ClientRoot%\client\client\install (
	echo "install folder is not exist,exit" >> "%temp%"\cau_install.log 2>&1
	exit(0)
)

if not exist %ClientRoot%\cau\config\CauInterface.properties (
	echo "CauInterface.properties is not exist,exit" >> "%temp%"\cau_install.log 2>&1
	exit(0)
)

pushd %ClientRoot%
echo "Begin to run exitscripts_imapfm.bat script..." >> "%temp%"\cau_install.log 2>&1

cd "%~dp0" 
 
cd ../bin

call env.bat

cd ../../../

start javaw -classpath "./client/client/tools/Notify Server Info Tool/notifyServerInfoTool.jar;./client/lib/3rd_tools/log4j-1.2.17.jar;./client/client/tools/Server Info Generation Tool/lib/ServerInfoTool.jar" com.swimap.fm.tools.notifyServerInfo.NotifyServerInfoUpdate

echo "End to run exitscripts_imapfm.bat script..." >> "%temp%"\cau_install.log 2>&1

popd