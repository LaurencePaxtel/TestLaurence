
If (Records in set:C195("UserSet")=1)
	vb_Dupliquer:=True:C214
	FORM SET INPUT:C55([LesCentres:9]; "LC_EcranSaisie")
	CREATE SET:C116([LesCentres:9]; "E_set")
	USE SET:C118("UserSet")
	LOAD RECORD:C52([LesCentres:9])
	DUPLICATE RECORD:C225([LesCentres:9])
	[LesCentres:9]LC_RéférenceID:1:=Uut_Numerote_Centres(->[LesCentres:9])
	[LesCentres:9]LC_Nom:4:=[LesCentres:9]LC_Nom:4+"  DUPLIQUÉ"
	SAVE RECORD:C53([LesCentres:9])
	
	MODIFY RECORD:C57([LesCentres:9]; *)
	ADD TO SET:C119([LesCentres:9]; "E_set")
	USE SET:C118("E_set")
	ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
	vb_Dupliquer:=False:C215
	CLEAR SET:C117("E_set")
Else 
	
End if 
