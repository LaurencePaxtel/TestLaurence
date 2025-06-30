If (Form event code:C388=Sur données modifiées:K2:15)
	
	//ORDER BY([LesCentres];[LesCentres]LC_Nom;>)
	//UNLOAD RECORD([LesCentres])
	//FIRST RECORD([LesCentres])
	//PREVIOUS RECORD([LesCentres])
	
	C_LONGINT:C283($L_Erreur)
	$L_Erreur:=CentreLits_Handle_query("nouvelle_date")
	
End if 