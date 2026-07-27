cd %~dp0\..\..\..\
exit /B 0
if not exist client\client\authenticate.flag (	
	echo "Start delete Authenticated Users Group rights at %date% %time%" > client\client\authenticate.flag   
    	set strA=false
	setlocal enabledelayedexpansion
	FOR /F "DELIMS=" %%i in ('ICACLS %cd%') do (
		echo %%i | find "Authenticated Users">nul&&set strA=true||set strA=false
		if "!strA!" == "true" (
			ICACLS %cd% /inheritance:d   
			ICACLS %cd% /remove:g "Authenticated Users"
			echo "Delete Authenticated Users Group rights at %date% %time%" >> client\client\authenticate.flag
			GOTO END
		)
	)	
)else (   
   echo "authenticate.flag exist already, nothing need change. %date% %time%" >> client\client\authenticate.flag
)
:END

