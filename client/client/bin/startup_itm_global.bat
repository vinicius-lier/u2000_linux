call env.bat
cd ..\

start javaw -classpath .\startuploader.jar -Xdebug -Xverify:all -Xms128m -Xmx512m -Dsun.java2d.noddraw=true -Dhelpapp=run_help.bat -Dsubsystem=com.swimap.itm -Djava.library.path=..\..\cau\lib;.\update\lib;..\lib  -DExtesnionRigestry.debug=true -DExtesionRegistry.cacheUse=true -Dscript.name="%~fp0" -Dfile.encoding=UTF-8 -DSingleFileChooserPath=true com.swimap.startup.Startup -debuglevel 1 -showtrace false -enabledebug true -tracefile DebugTrace.txt %*