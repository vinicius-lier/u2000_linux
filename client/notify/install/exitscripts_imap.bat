set installRoot=%~dp0
pushd %installRoot%

call exitscripts_imapfm.bat
call ../upgradeScript/deleteJar.bat
