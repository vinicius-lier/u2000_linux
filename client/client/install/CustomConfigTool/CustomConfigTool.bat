echo exec CustomConfigTool.bat
set INSTALLROOT=%1

cd /d %INSTALLROOT%\client\client\bin
call env.bat
cd ..\install\CustomConfigTool
java -classpath "../../tools/Server Info Generation Tool/lib/ServerInfoTool.jar;../../../lib/iview.jar;../../../lib/3rd_tools/log4j-1.2.17.jar;../../../lib/3rd_tools/jdom.jar" com.swimap.install.config.Starter %*