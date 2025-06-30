

If ([LesCentres:9]LC_RéférenceID:1>0)
	READ WRITE:C146([LesCentres:9])
	If (i_NonVerrou(->[LesCentres:9]))
		FORM SET INPUT:C55([LesCentres:9]; "LC_EcranVisu")
		MODIFY RECORD:C57([LesCentres:9]; *)
		UNLOAD RECORD:C212([LesCentres:9])
	End if 
	READ ONLY:C145([LesCentres:9])
	
Else 
	
	StrAlerte(22; "")
End if 