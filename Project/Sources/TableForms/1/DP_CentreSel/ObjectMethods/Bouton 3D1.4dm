If (Form event code:C388=Sur clic:K2:4)
	
	ALL RECORDS:C47([LesCentres:9])
	MultiSoc_Filter(->[LesCentres:9])
	vL_NbFichesCL:=Records in selection:C76([LesCentres:9])
	ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
	FIRST RECORD:C50([LesCentres:9])
	PREVIOUS RECORD:C110([LesCentres:9])
End if 