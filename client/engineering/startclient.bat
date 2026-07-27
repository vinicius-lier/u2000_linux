@ECHO OFF
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: FileName: startclient.bat                                        ::
:: FilePath: %MSCLIENTROOT%/engineerint/                            ::
:: Description: Windows the client startup script of deployment tool::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
SETLOCAL ENABLEDELAYEDEXPANSION
GOTO CHECKARGS


::1.Check the startup parameters
:CHECKARGS
IF "%1"=="/?" GOTO HELPINFO
FOR %%H IN (-h,-H,-help,-HELP) DO IF "%%H"=="%1" GOTO HELPINFO
SET CURRENTDIR=%~dp0
set OPERATION_IP="127.0.0.1"
CD /D !CURRENTDIR!
GOTO CHECKJRE


::2.Check JRE
:CHECKJRE

::Remove the redundant quotes of variable
for /f "tokens=1-4 delims=/- " %%a in ('date /t') do (
IF "%%a"=="??" (
    set year=%%b& set day=%%c& set month=%%d
)ELSE (
       set year=%%a& set day=%%b& set month=%%c
)
)
set hh=%TIME:~0,2%
set mn=%TIME:~3,2%
set seconds=%TIME:~6,2%
set first=%TIME:~0,1%
set second=%TIME:~1,1%
if "%first%"==" " (
	set hh=0%second%
)
SET LOGTIME=%year%%day%%month%%hh%%mn%%seconds%

IF DEFINED IMAP_JAVA_HOME (
	SET "IMAP_JAVA_HOME_TMP=%IMAP_JAVA_HOME:"=%"
) ELSE (
	SET IMAP_JAVA_HOME_TMP=""
)
SET IMAP_JAVA_HOME=!CURRENTDIR!..\..\OSSJRE\jre_win\
IF NOT EXIST !IMAP_JAVA_HOME!\bin\javaw.exe (
	IF EXIST !CURRENTDIR!..\..\jre\bin\javaw.exe (
		SET IMAP_JAVA_HOME=!CURRENTDIR!..\..\jre\
	) ELSE IF EXIST "!IMAP_JAVA_HOME_TMP!\bin\javaw.exe" (
		SET "IMAP_JAVA_HOME=!IMAP_JAVA_HOME_TMP!"
	) ELSE IF EXIST %SystemDrive%\OSSJRE\jre_win\bin\javaw.exe (
		SET IMAP_JAVA_HOME=%SystemDrive%\OSSJRE\jre_win
	) ELSE IF EXIST C:\OSSJRE\jre_win\bin\javaw.exe (
		SET IMAP_JAVA_HOME=C:\OSSJRE\jre_win
	) ELSE (
		ECHO Can not find IMAP_JAVA_HOME,exit start!
		GOTO END
	)
)
IF NOT DEFINED MSCLIENTROOT (
	PUSHD !CURRENTDIR!
	CD ..
	SET MSCLIENTROOT=!CD!
	POPD
)
SET INSTALLROOT=!CURRENTDIR!..\..
GOTO GETLANGUAGE


::3.Get NMS language
:GETLANGUAGE
SET getOSSLanguage=
REM The first step, get the language from the locale configuration file of NMS
IF EXIST "!INSTALLROOT!" (
	SET locale=!INSTALLROOT!\client\client\locale.properties
) ELSE (
	SET locale=..\client\locale.properties
)
IF  EXIST !locale! (
	FOR /F "usebackq eol=# tokens=1,2 delims==" %%i IN ("!locale!") DO (
		IF "%%i"=="language" (
			SET getOSSLanguage=%%j
		) ELSE IF "%%i"=="country" (
			SET getOSSCountry=%%j
		)
	)
	IF NOT "!getOSSLanguage!"=="" (
		SET getOSSLanguage=!getOSSLanguage:~0,2!
	)
)

REM The second step, if can not get the language from the first step, then get the current OS language
IF "!getOSSLanguage!"=="" (
	SET launchcheck=!MSCLIENTROOT!\launchcheck
	IF EXIST !launchcheck! (
		FOR /F "usebackq tokens=1,2 delims=:" %%i IN ("!launchcheck!") DO (
			IF "%%i"=="OSLang " (
				SET getOSSLanguage=%%j
			)
		)
		IF NOT "!getOSSLanguage!"=="" (
			SET getOSSLanguage=!getOSSLanguage:~-2!
		)
	)
)
REM The third step, if can not get the language from the second step, then the default language is set to en
FOR %%L IN (zh,en) DO IF "%%L"=="%getOSSLanguage%" GOTO LAUNCHCHECKCLIENT
SET getOSSLanguage=en
GOTO LAUNCHCHECKCLIENT


::4.Initial start checking
:LAUNCHCHECKCLIENT
PUSHD %CD%
CD ..
"!IMAP_JAVA_HOME!\bin\java" -jar engineering/plugins/LaunchCheck.jar 3 startClient
SET getLine=
SET a=
FOR /F "usebackq tokens=1* delims==" %%i IN (`type launchcheck`) DO (
	SET getLine=%%i
	for /f "tokens=1-4" %%a in ("!getLine!") do (
		if "%%a"=="whetherContinue" (
			if "%%c"=="false" (
				SET ERROR_CODE=1
				GOTO END
			)
		)
	)
)

FOR %%M IN (-cmd,deploy,storage,incinstall) DO IF "%%M"=="%1" GOTO CMDMode
IF NOT "%1"=="" GOTO INVALIDPARA
GOTO GUIMode


::GUI mode
:GUIMode
IF "%getOSSLanguage%"=="zh" (
	SET launchImage=zh_CN\launch.gif
) ELSE (
	SET launchImage=en_US\launch.gif
)
IF EXIST engineering\resource_product\!launchImage! (
	SET splashPath=engineering\resource_product\!launchImage!
) ELSE (
	SET splashPath=engineering\resource\!launchImage!
)

start "" /MIN "!IMAP_JAVA_HOME!\bin\javaw" -Dlanguage=%getOSSLanguage% -DoperationIp=%OPERATION_IP% -Xms64m -Xmx128m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=256m -XX:CompressedClassSpaceSize=256m -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=95 -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -splash:!splashPath! -Dengr.launcher.file=engineering/conf/launch/deployclient_launcher.xml -Dequinox.conf=engineering/conf/equinoxClient.ini -Dos.native.path=engineering/lib -DCoreFramework.logFilePath=engineering/conf/loggerservice_client.cfg -DenableDataTransfer=client -Djava.library.path=engineering/lib/windows -Drunway=maintenance -DinstallDiskMode=gui -DinstallType=msuiteclient -DstartTimer=false -DisClient=true -classpath .\classes;.\engineering\jre\jre_win\jre1.6.0_06\lib;.\engineering\lib\launcher.jar;.\engineering\lib\equinox.jar com.oss.core.launcher.Launcher %* > %temp%\osgi_console_deployclient_%LOGTIME%.log  2>&1
SET ERROR_CODE=%ERRORLEVEL%

echo Wscript.Sleep 1000>delay.vbs
CScript //B delay.vbs
del delay.vbs

GOTO END


::CMD mode
:CMDMode
"!IMAP_JAVA_HOME!\bin\java" -Dlanguage=%getOSSLanguage% -DoperationIp=%OPERATION_IP% -Xverify:all -Xms64m -Xmx128m -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=95 -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -Dengr.launcher.file=engineering/conf/launch/deployclient_launcher.xml -DCoreFramework.logFilePath=engineering/conf/loggerservice_client.cfg -Dequinox.conf=engineering/conf/equinoxClient.ini -DenableDataTransfer=client -Drunway=maintenance -DstartTimer=true -DinstallDiskMode=cmd -Djava.library.path=engineering/lib/windows -DinstallType=msuiteclient -DisClient=true -classpath .\classes;.\engineering\jre\jre_win\jre1.6.0_06\lib;.\engineering\lib\launcher.jar;.\engineering\lib\equinox.jar com.oss.core.launcher.Launcher %*
SET ERROR_CODE=%ERRORLEVEL%
GOTO END


::Parameter error
:INVALIDPARA
ECHO The parameter %1 is invalid, please read following help info:


::Print help information::
:HELPINFO
ECHO Please use following command line:
ECHO *********************************************************************************
ECHO %0
ECHO %0  [-h ^| -H ^| -help ^| -HELP]
ECHO %0  -gui
ECHO %0  deploy -ip ServerIP -port ServerPort -username UserName -help
ECHO %0  storage -ip ServerIP -port ServerPort -username UserName -help
ECHO *********************************************************************************


::Exit the script
:END
SETLOCAL DISABLEDELAYEDEXPANSION
POPD
EXIT /B %ERROR_CODE%