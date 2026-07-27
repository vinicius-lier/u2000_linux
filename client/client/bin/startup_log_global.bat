call env.bat
cd ..\
start javaw -classpath .\startuploader.jar -Xdebug -Xms128m -Xmx512m -XX:+HeapDumpOnOutOfMemoryError -Dsun.java2d.noddraw=true -Dhelpapp=run_help.bat -Dsubsystem=log -Djava.library.path=.\update\lib;..\lib;..\..\cau\lib  -DExtesnionRigestry.debug=true  -DExtesionRegistry.cacheUse=true -Dscript.name="%~fp0" -Dfile.encoding=UTF-8 -DSingleFileChooserPath=true com.swimap.startup.Startup -debuglevel 1  -showtrace false -enabledebug true -tracefile DebugTrace.txt %*

 
