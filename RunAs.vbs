Set WshShell = WScript.CreateObject("WScript.Shell")
Dim sInput
sInput = "DELL"
WshShell.run("runas /user:"+sInput+ " cmd.exe")
WScript.Sleep 100
WshShell.SendKeys "123{ENTER}"

