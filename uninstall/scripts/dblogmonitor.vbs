Const ForReading = 1, ForWriting = 2, ForAppending = 3
Const TristateUseDefault = -2, TristateTrue = -1,TristateFalse = 0

Function GetFileSize(filespec)
    Dim fs, f
    Set fs = CreateObject("Scripting.FileSystemObject")
    Set f = fs.GetFile(filespec)
    GetFileSize = f.Size
End Function



Sub log_cycle()
	Set fs = CreateObject("Scripting.FileSystemObject")
	
	cyclesql = "sp_cycle_errorlog"
	
	set WshShell = WScript.CreateObject("WScript.Shell")
	WshShell.run("osql -E -Q " & cyclesql)
	installDiskRoot = fs.GetParentFolderName(fs.GetParentFolderName(WScript.ScriptFullName)) & "\"
	engrDir = fs.GetParentFolderName(installDiskRoot) & "\"
	wshshell.Run "cmd /c "&engrDir&"engineering\script\tools\businessoperatelog.bat ""dblogmonitor.bat;successful;cycle sql log."" information", 0

end Sub

logFile = "C:\MSDATA\MSSQL10.MSSQLSERVER\MSSQL\Log\ERRORLOG"
max = 150*1024*1024 
Dim fso 
Set fso = CreateObject("Scripting.FileSystemObject") 
If (fso.FileExists(logFile)) Then 
    size = GetFileSize(logFile) 
    If size > max Then 
        call log_cycle
    End If 
End If



