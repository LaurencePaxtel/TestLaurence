

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		//ORDER BY([LesCentres];[LesCentres]LC_Nom;>)
		//UNLOAD RECORD([LesCentres])
		//FIRST RECORD([LesCentres])//24/1/17
		//PREVIOUS RECORD([LesCentres])
		
		C_LONGINT:C283($L_Erreur)
		$L_Erreur:=CentreLits_Handle_query("tri_nom")
End case 