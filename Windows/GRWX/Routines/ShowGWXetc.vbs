ReDim hideupdates(WScript.Arguments.Count-1)

For i = 0 To WScript.Arguments.Count-1
  If InStr(WScript.Arguments(i), " ") > 0 Then
    hideupdates(i) = Chr(34) & WScript.Arguments(i) & Chr(34)
  Else
    hideupdates(i) = WScript.Arguments(i)
  End If
Next



'Dim hideupdates(12)

'hideupdates(0) = "KB2952664"
'hideupdates(1) = "KB3035583"
'hideupdates(2) = "KB3021917"
'hideupdates(3) = "KB3022345"
'hideupdates(4) = "KB3068708"
'hideupdates(5) = "KB3075249"
'hideupdates(6) = "KB3080149"
'hideupdates(7) = "KB2990214"
'hideupdates(8) = "KB2976978"
'hideupdates(9) = "KB3012973"
'hideupdates(10) = "KB3044374"
'hideupdates(11) = "KB3046480"


set updateSession = createObject("Microsoft.Update.Session")
set updateSearcher = updateSession.CreateupdateSearcher()

Set searchResult = updateSearcher.Search("IsInstalled=0 and Type='Software'")

For i = 0 To searchResult.Updates.Count-1
set update = searchResult.Updates.Item(i)
For j = LBound(hideupdates) To UBound(hideupdates)
' MsgBox hideupdates(j)
if instr(1, update.Title, hideupdates(j), vbTextCompare) = 0 then
  ' Wscript.echo "No match found for " & hideupdates(j)
else
Wscript.echo "..." & hideupdates(j)

update.IsHidden = False
end if
Next
Next