cd /d %1
cd plugins
cd alarmclienttool
call env.bat
cd ..
cd ..
java -Xverify:all -Xms128m -Xmx512m -Dfile.encoding=UTF-8 -jar ./plugins/alarmclienttool/alarm_tool.jar %2