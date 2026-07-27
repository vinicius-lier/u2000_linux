@echo off

rem ODBC optimization
echo "start to setPwdUnlimited"
net Accounts /maxpwage:Unlimited
if not %errorlevel% == 0 (
	echo "Execute the cmd: net Accounts /maxpwage:Unlimited Failed."
	exit /b 1
) else (
	echo "Execute the cmd: net Accounts /maxpwage:Unlimited Successful."
	net user ossuser > setPwdUnlimited.result
	exit /b 0
)
echo "excute setPwdUnlimited end"

