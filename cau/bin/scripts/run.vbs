Dim WshShell,myParameter, strApplication, cauNohupEnv, cauNohupEnvExpand
Dim showWindow

Set WshShell = CreateObject("WScript.Shell")
Set objShell = CreateObject("Shell.Application")

cauNohupEnvExpand=WshShell.ExpandEnvironmentStrings("%CAU_NO_HUP_WIN%")
If  cauNohupEnvExpand="%CAU_NO_HUP_WIN%" Then
	cauNohupEnvExpand = "1"
Else
	cauNohupEnvExpand = "0"
End If
showWindow = CInt(cauNohupEnvExpand)

Set fso = CreateObject("Scripting.FileSystemObject")
    installRoot = Chr(34) & fso.GetAbsolutePathName("..\..\") & Chr(34)
    Set WshShell = WScript.CreateObject("wscript.shell")
    

If WScript.Arguments.Count = 0 Then
	WScript.echo "This file cannot be run independently." 	
Else
	strApplication = WScript.Arguments(0)
	For i = 2 To WScript.Arguments.Count Step 1
                 myParameter = myParameter + " " + WScript.Arguments(i-1)
    Next
		objShell.ShellExecute strApplication , myParameter , "", "runas", showWindow
End If