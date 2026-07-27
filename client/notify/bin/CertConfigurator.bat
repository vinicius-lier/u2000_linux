call env.bat
cd ..\

set IVIEW_3RD_LIB_HOME=..\lib\3rd_tools

set IVIEW_LIB_PATH=%IVIEW_3RD_LIB_HOME%\fstrucomm.jar;%IVIEW_3RD_LIB_HOME%\batik.jar;%IVIEW_3RD_LIB_HOME%\dockingFramesCommon.jar;%IVIEW_3RD_LIB_HOME%\dockingFramesCore.jar;%IVIEW_3RD_LIB_HOME%\iText-2.1.7.jar;%IVIEW_3RD_LIB_HOME%\iviewidl_oem.jar;%IVIEW_3RD_LIB_HOME%\jcchart3dj3dK.jar;%IVIEW_3RD_LIB_HOME%\jcchartK.jar;%IVIEW_3RD_LIB_HOME%\jcelementsK.jar;%IVIEW_3RD_LIB_HOME%\jcfieldK.jar;%IVIEW_3RD_LIB_HOME%\jcommon-1.0.20.jar;%IVIEW_3RD_LIB_HOME%\jdom.jar;%IVIEW_3RD_LIB_HOME%\jfreechart-1.0.19.jar;%IVIEW_3RD_LIB_HOME%\jhall.jar;%IVIEW_3RD_LIB_HOME%\jxl.jar;%IVIEW_3RD_LIB_HOME%\log4j-1.2.14.jar;%IVIEW_3RD_LIB_HOME%\unifont.jar;%IVIEW_3RD_LIB_HOME%\xalan.jar;%IVIEW_3RD_LIB_HOME%\xercesImpl.jar;%IVIEW_3RD_LIB_HOME%\xml-apis.jar

start javaw -Xverify:all -Dfile.encoding=UTF-8 -cp ../lib/3rd_tools/jsch-0.1.54.jar;../lib/3rd_tools/log4j-1.2.17.jar;../lib/3rd_tools/slf4j-api-1.7.22.jar;../lib/3rd_tools/slf4j-log4j12-1.7.22.jar;../lib/3rd_tools/jcl-over-slf4j-1.7.22.jar;../lib/imapsslbase.jar;../lib/baseutil.jar;../lib/imapsslapp.jar;../lib/iview.jar;../lib/startup.jar;%IVIEW_LIB_PATH%;./lib/helpSupportLib/jhall.jar com.swimap.imap.ssl.tools.CertConfigurator style/defaultstyle/conf/ssl/
