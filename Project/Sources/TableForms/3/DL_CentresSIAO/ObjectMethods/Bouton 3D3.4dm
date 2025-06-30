If (Form event code:C388=Sur clic:K2:4)
	
	QUERY:C277([LesCentres:9])
	If (OK=1)
		QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_Prestation:55=False:C215)
	End if 
	
	ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
	FIRST RECORD:C50([LesCentres:9])
	PREVIOUS RECORD:C110([LesCentres:9])
	
	
End if 