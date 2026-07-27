Set WshShell = WScript.CreateObject("WScript.Shell") 
Set fso = CreateObject("scripting.FileSystemObject")  
weblctPath = createobject("Scripting.FileSystemObject").GetFile(Wscript.ScriptFullName).ParentFolder.Path
stopWeblctPath = weblctPath 
' startWeblctPath = weblctPath 
' uninstallPath = u2000Path & "\cau\bin"

strDesktop = WshShell.SpecialFolders("allusersDesktop")
strStartMenu = WshShell.SpecialFolders("AllUsersPrograms") + "\U2000LCT"

' Create Desktop ShortCut
'createFolder(WshShell.SpecialFolders("Programs") & "\U2000LCT\")
If fso.FileExists(strDesktop + "\U2000LCT.lnk") = false Then 
	Call createShortCut("d", "\U2000LCT.lnk", strStartMenu, stopWeblctPath & "\imapclient_u2k.ico, 0", "", strStartMenu)
End If

if fso.FileExists(strDesktop + "\U2000LCT 客户端.lnk") then 
 Set shortcut=fso.getFile(strDesktop + "\U2000LCT 客户端.lnk") 
 fso.deletefile(shortcut)
end If
 if fso.FileExists(strDesktop + "\U2000LCT 服务器.lnk") then 
 Set shortcut=fso.getFile(strDesktop + "\U2000LCT 服务器.lnk") 
 fso.deletefile(shortcut)
end If
If fso.FileExists(strDesktop + "\U2000LCT 系统监控.lnk") then 
Set shortcut=fso.getFile(strDesktop + "\U2000LCT 系统监控.lnk") 
 fso.deletefile(shortcut)
end If
If fso.FileExists(strDesktop + "\网元软件管理.lnk") then 
 Set shortcut=fso.getFile(strDesktop + "\网元软件管理.lnk") 
 fso.deletefile(shortcut)
end If
If fso.FileExists(strDesktop + "\卸载 U2000LCT.lnk") then 
 Set shortcut=fso.getFile(strDesktop + "\卸载 U2000LCT.lnk") 
 fso.deletefile(shortcut)
end If
If fso.FileExists(strDesktop + "\U2000LCT Client.lnk") then 
 Set shortcut=fso.getFile(strDesktop + "\U2000LCT Client.lnk") 
 fso.deletefile(shortcut)
end If
If fso.FileExists(strDesktop + "\U2000LCT Server.lnk") then 
 Set shortcut=fso.getFile(strDesktop + "\U2000LCT Server.lnk") 
 fso.deletefile(shortcut)
end If
If fso.FileExists(strDesktop + "\U2000LCT System Monitor.lnk") then 
Set shortcut=fso.getFile(strDesktop + "\U2000LCT System Monitor.lnk") 
 fso.deletefile(shortcut)
end If
If fso.FileExists(strDesktop + "\Uninstall U2000LCT.lnk") then 
Set shortcut=fso.getFile(strDesktop + "\Uninstall U2000LCT.lnk") 
 fso.deletefile(shortcut)
End If
If fso.FileExists(strDesktop + "\NE Software Management.lnk") then 
Set shortcut=fso.getFile(strDesktop + "\NE Software Management.lnk") 
 fso.deletefile(shortcut)
End If
 
 
' Call deleteFile("d", "\xie.lnk", "", "", "", "")
' Call createShortCut("d", "\U2000 网络管理系统维护工具.lnk", engrPath & "\startclient.bat", clientPath & "\MSuite_u2k.ico, 0", "", clientPath)
' Call createShortCut("d", "\U2000 系统监控.lnk", clientPath & "\startup_sysmonitor_global.bat", clientPath & "\imapserver_u2k.ico, 0", "", clientPath)
' Call createShortCut("d", "\网元软件管理.lnk", clientPath & "\startup_dc_global.bat", clientPath & "\dcclient.ico, 0", "", clientPath)

' Create Start -> Programs ShortCut
' createFolder(WshShell.SpecialFolders("Programs") & "\网络管理系统\")
' Call createShortCut("p", "\网络管理系统\U2000 客户端.lnk", clientPath & "\startup_all_global.bat", clientPath & "\imapclient_u2k.ico, 0", "", clientPath)
' Call createShortCut("p", "\网络管理系统\U2000 网络管理系统维护工具.lnk", engrPath & "\startclient.bat", clientPath & "\MSuite_u2k.ico, 0", "", engrPath)
' Call createShortCut("p", "\网络管理系统\U2000 系统监控.lnk", clientPath & "\startup_sysmonitor_global.bat", clientPath & "\imapserver_u2k.ico, 0", "", clientPath)
' Call createShortCut("p", "\网络管理系统\网元软件管理.lnk", clientPath & "\startup_dc_global.bat", clientPath & "\dcclient.ico, 0", "", clientPath)
' Call createShortCut("p", "\网络管理系统\U2000 帮助.lnk", clientPath & "\help\zh_CN\r_welcome.html", clientPath & "\nmsmanual_u2k.ico, 0", "", clientPath)
' Call createShortCut("p", "\网络管理系统\卸载 U2000.lnk", uninstallPath & "\uninstall.vbs", clientPath & "\uninstall_u2k.ico, 0", "", uninstallPath)

' Clean the object
Set WshShell = nothing
Set fso = Nothing

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Sub: this Sub is used to create shortcut in windows
'
' @param strDect       the shortcut type, ie desktop, start->programs
' @param shortCutPath  the shortcut path where you would like to put the shortcut
' @param targetPath    the program which the shortcut point to
' @param iconLocation  the icon of the shortcut
' @param desc          the description of the shortcut
' @param workDir       the working directory
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub createShortCut(strType, shortCutPath, targetPath, iconLocation, desc, workDir)
    Select Case lcase(strType)
        Case "d"  strType = "Desktop"
        Case "s"  strType = "Startmenu"
        Case "p"  strType = "Programs"
        Case "t"  strType = "Startup"
        Case "f"  strType = "Favorites"
        Case "ad" strType = "allusersDesktop"
        Case "as" strType = "allusersStartmenu"
        Case "ap" strType = "allusersPrograms"
        Case "at" strType = "allusersStartup"
        Case "af" strType = "allusersFavorites"
    End Select
    strType = WshShell.SpecialFolders(strType)
    
    If fso.FileExists(strType & shortCutPath) Then
    	Exit Sub
    End If

    'The path where you need to put the shortcut
    Set oShellLink = WshShell.CreateShortcut(strType & shortCutPath) 

    'the target in the shortcut
    oShellLink.TargetPath = targetPath 

    'the run type
    oShellLink.WindowStyle = 1 

    'the shurtcut icon
    oShellLink.IconLocation = iconLocation

    'the comment of shortcut
    oShellLink.Description = desc 

    'the working directory
    oShellLink.WorkingDirectory = workDir 
    
    'create the shortcut
    oShellLink.Save
    
    Set oShellLink = Nothing
End Sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' this sub is use to create folder
'
' @param folderPath: the folder path going to be created
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Sub createFolder(folderPath)
    If fso.FolderExists(folderPath) = false Then
        fso.CreateFolder folderPath
    End If    
End Sub