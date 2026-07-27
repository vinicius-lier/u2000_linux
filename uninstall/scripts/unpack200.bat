@echo off
setlocal ENABLEDELAYEDEXPANSION

SET OSS_ROOT=%~1
SET PACKAGE_NAME=%2
SET CUR_PATH=!cd!

rem Switch to the network directory script execution
cd /d "!OSS_ROOT!"

SET JRE_HOME=!OSS_ROOT!\jre

if exist "!JRE_HOME!\bin\unpack200.exe" goto hasjre
set JRE_HOME=!IMAP_JAVA_HOME!
if exist "!JRE_HOME!\bin\unpack200.exe" goto hasjre
set JRE_HOME=C:\OSSJRE\jre_win

:hasjre

SET unpack200="!JRE_HOME!\bin\unpack200.exe"
mkdir uninstall\data\pack200\log >nul 2>&1
set errorlog=uninstall\data\pack200\log\unpackerror
date /t >!errorlog!
echo "uninstall\data\pack200\!PACKAGE_NAME!.pack200lst"
if not exist "uninstall\data\pack200\!PACKAGE_NAME!.pack200lst" (
    echo "!PACKAGE_NAME!.pack200lst does not exist.End this script"
	exit 0
)

FOR /F "delims==" %%i IN ('dir /B uninstall\data\pack200\!PACKAGE_NAME!.pack200lst') DO (
	echo "===========Start to deal the file %%i,============"
	rem Get package description file
	set file=%%i
	rem Modify the file format for the package description file. Xml
	set descriptfile=uninstall\data\unzipfile\!file:~0,-11!.xml
	set xmltmpfile=!descriptfile!_tmp.txt
	rem Begin processing package file
	set errorflag=0
	FOR /F "usebackq tokens=1,2 delims==" %%j IN (uninstall\data\pack200\!file!) DO (
		set _unpackfile=%%j
		if exist "!_unpackfile!" (
			rem Get the decompressed file
			set unpackfile=!_unpackfile:~0,-5!
			rem Start unpacking
			set unpackrawname=%%~nj
			set unpackname=!unpackrawname!.pack
			echo Deal the file !unpackfile!
			%unpack200% "!_unpackfile!" "!unpackfile!"
			if !ERRORLEVEL! == 0 (
				rem Remove decompression successful package
				set tempPath=!_unpackfile:/=\!
				del /q "!tempPath!"
				rem Refresh package description file
				if exist !descriptfile! (
					for /f "delims=" %%k in ('type "!descriptfile!"') do (
						set str=%%k
						set "str=!str:.pack=!"
						echo !str! >>!xmltmpfile! 2>nul
					)
					echo Successed to unpack the package !unpackfile!
					move !xmltmpfile! !descriptfile! >nul 2>&1
				)
			)else (
				set /a errorflag+=1
				echo "Failed to unpack file !_unpackfile!" >>!errorlog!
			)
		)
	)
	if !errorflag! == 0 (
		echo "Successed to unpack all the packages in !file!"
	)else (
		echo "Some errors occured in unpacking the packages in !file!"
		move uninstall\data\pack200\!file! uninstall\data\pack200\!file!.txt >nul 2>&1
		exit 1
	)
	
	move uninstall\data\pack200\!file! uninstall\data\pack200\!file!.txt >nul 2>&1
)