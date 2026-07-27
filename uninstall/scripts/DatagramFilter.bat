@echo off
set curdir=%~dp0
set ossroot=%1
set businesstypepath=%ossroot%\engr\tools\getBusinessType.bat
for /f "delims=" %%i in ('call %businesstypepath%') do set "installtype=%%i"
set var=%installtype: =%
if "%var%" == "install" (
	    title Disable 135 137 138 139 445 Port.
		echo Start to disable 135 137 138 139 445 Port, please wait...
		netsh ipsec static delete all
		netsh ipsec static add policy name=HW_SecurityPolicy
		netsh ipsec static add filterlist name=HW_FilterBlock
		netsh ipsec static add filter filterlist=HW_FilterBlock srcaddr=Any dstaddr=Me dstport=135 protocol=TCP
		netsh ipsec static add filter filterlist=HW_FilterBlock srcaddr=Any dstaddr=Me dstport=137 protocol=UDP
		netsh ipsec static add filter filterlist=HW_FilterBlock srcaddr=Any dstaddr=Me dstport=138 protocol=UDP
		netsh ipsec static add filter filterlist=HW_FilterBlock srcaddr=Any dstaddr=Me dstport=139 protocol=TCP
		netsh ipsec static add filter filterlist=HW_FilterBlock srcaddr=Any dstaddr=Me dstport=445 protocol=TCP
		netsh ipsec static add filteraction name=HW_Block action=block
		netsh ipsec static add rule name=HW_RuleBlock policy=HW_SecurityPolicy filterlist=HW_FilterBlock filteraction=HW_Block
		netsh ipsec static set policy name=HW_SecurityPolicy assign=y
		echo Done!
	) else (
		echo The businesstype is "%var%" not install, skip Disable Port.
	)
