' Uninstall Software
' Contact Mike Thomas | mthomas@illumina.com |858-736-3425 
' Contact Edward Thomas | Edward@ThomasITServices | 858-232-0340 
 
Option Explicit

If WScript.Arguments.Named.Exists("elevated") = False Then
'Launch the script again as administrator
Dim StartMeUP : Set StartMeUP = createObject("Shell.Application")
Call StartMeUP.ShellExecute("wscript.exe", chr(34) + WScript.ScriptFullName + chr(34) + " /elevated", "", "runas", 1)
Else
On Error Resume Next
Err.Clear
Dim objShell : Set objShell = createobject("Wscript.shell")
Dim oEnv : Set oEnv = objShell.Environment("PROCESS")
Dim dlgName: dlgName="Uninstalling Software"
Dim dlgCompleted: dlgCompleted="Program Removal Completed!"
Dim objSoftware
Dim strComputer: strComputer = "."
Dim objWMIService: Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Dim colSoftware: Set colSoftware = objWMIService.ExecQuery ("Select * from Win32_Product Where Name like 'Java%'")

'Try
For Each objSoftware in colSoftware
objShell.popup "Uninstalling Name: " & objSoftware.Name & " v. " & objSoftware.Version,10,dlgName
objSoftware.Uninstall()
Next
'catch
'End Try
objShell.popup dlgCompleted,10,dlgName

End if
