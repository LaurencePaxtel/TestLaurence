
Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		//ORDER BY([LesCentres];[LesCentres]LC_Lieu;>;*)
		//ORDER BY([LesCentres];[LesCentres]LC_Type;>;*)
		//ORDER BY([LesCentres];[LesCentres]LC_RespRegul;>)
		
		//UNLOAD RECORD([LesCentres])
		
		//FIRST RECORD([LesCentres])
		//PREVIOUS RECORD([LesCentres])
		
		
		
		C_LONGINT:C283($L_Erreur)
		$L_Erreur:=CentreLits_Handle_query("tri_lieu")
		
End case 