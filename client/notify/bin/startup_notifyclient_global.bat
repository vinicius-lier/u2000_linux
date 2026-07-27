call env.bat

cd ../

start javaw -classpath .\startuploader.jar -Xdebug -Xverify:all -Xms128m -Xmx512m -Dsun.java2d.noddraw=true -Dhelpapp=run_help.bat -XX:+HeapDumpOnOutOfMemoryError -Dsubsystem=notifyclient  -Djava.library.path=.\update\lib;..\lib;..\..\cau\lib  -DExtesnionRigestry.debug=true -Dfile.encoding=UTF-8 -DExtesionRegistry.cacheUse=true -Dscript.name="%~fp0" -DSingleFileChooserPath=true com.swimap.startup.Startup -debuglevel 1 -showtrace false -enabledebug true -tracefile DebugTrace.txt %*