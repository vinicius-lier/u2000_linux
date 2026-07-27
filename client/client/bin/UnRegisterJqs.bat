@echo off
set jqsUnRegisterRoot=%~dp0
pushd %jqsUnRegisterRoot%

cd ..\..\..\
set JQS_JAVA_HOME="%cd%\jre"

net session >nul 2>&1
if %errorLevel%== 0 (
	%JQS_JAVA_HOME%\bin\jqs -disable 1>nul 2>nul
	%JQS_JAVA_HOME%\bin\jqs -unregister 1>nul 2>nul
) else (
	echo Failure: Current permissions inadequate.
)
popd