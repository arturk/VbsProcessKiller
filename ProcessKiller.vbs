' Script that kills processes that run longer then 4 hours

Set objFS = CreateObject("Scripting.FileSystemObject")
Set WshShell = CreateObject("WScript.Shell")
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
  & "{impersonationLevel=impersonate}!\\" _
  & strComputer & "\root\cimv2")

Set dtmInstallDate = CreateObject( _
  "WbemScripting.SWbemDateTime")

Set colProcesses = objWMIService.ExecQuery( _
  "select * from win32_process where Name = 'ProcessName.exe'" )

For Each objProcess in colProcesses
   If int(objProcess.KernelModeTime / (60 * 1000)) > 30 Then
     WshShell.Exec "taskkill /PID " & objProcess.ProcessID 
   End If

Next