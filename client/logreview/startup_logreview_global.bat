cd ..\client\bin
call env.bat

cd ..\..\logreview
cd logreviewtool

copy /y ..\..\client\locale.properties locale.properties
start javaw -Xverify:all -Xms128m -Xmx256m -Dfile.encoding=UTF-8 -jar LogReviewTool.jar
cd ..