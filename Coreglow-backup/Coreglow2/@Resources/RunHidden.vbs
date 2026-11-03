' Runs a command line with no window: wscript.exe RunHidden.vbs <program> [arguments...]
Dim sh, i, cmd
Set sh = CreateObject("WScript.Shell")
For i = 0 To WScript.Arguments.Count - 1
    If InStr(WScript.Arguments(i), " ") > 0 Then
        cmd = cmd & """" & WScript.Arguments(i) & """ "
    Else
        cmd = cmd & WScript.Arguments(i) & " "
    End If
Next
sh.Run cmd, 0, False
