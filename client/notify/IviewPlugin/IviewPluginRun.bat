echo off

cd ..\bin

call env.bat

cd ..\IviewPlugin
java -Dosgi.configuration.area=./configuration -Dosgi.bundles="file:///%~dp0/IviewPlugin_1.0.0.jar@start" -jar ../../lib/3rd_tools/org.eclipse.osgi_3.7.2.v20120110-1415.jar -console
