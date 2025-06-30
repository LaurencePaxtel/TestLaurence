If (Records in selection:C76([LesCentres:9])>0)
	ve_NoPage:=0
	ORDER BY:C49([LesCentres:9])
	FIRST RECORD:C50([LesCentres:9])
	
	FORM SET OUTPUT:C54([LesCentres:9]; "LC_Print1")
	_O_PAGE SETUP:C299([LesCentres:9]; "LC_Print1")
	PRINT SETTINGS:C106
	If (OK=1)
		PRINT SELECTION:C60([LesCentres:9]; *)
	End if 
	
	FORM SET OUTPUT:C54([LesCentres:9]; "LC_Liste")
End if 