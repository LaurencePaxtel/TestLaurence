If (Macintosh control down:C544 | Windows Ctrl down:C562)
	QR REPORT:C197([TAbles:12]; Char:C90(1))
Else 
	FORM SET OUTPUT:C54([TypesTables:11]; "TT_ListePrint")
	
	_O_PAGE SETUP:C299([TypesTables:11]; "TT_ListePrint")
	PRINT SETTINGS:C106
	
	If (OK=1)
		PRINT RECORD:C71([TypesTables:11]; *)
	End if 
	
	FORM SET OUTPUT:C54([TypesTables:11]; "TT_Liste")
End if 