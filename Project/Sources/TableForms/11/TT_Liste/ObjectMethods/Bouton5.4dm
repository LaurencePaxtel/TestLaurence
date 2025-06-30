Case of 
	: (Form event code:C388=Sur clic:K2:4)
		ALL RECORDS:C47([TypesTables:11])
		
		// Modifié par : Scanu Rémy (22/12/2022)
		QUERY SELECTION:C341([TypesTables:11]; [TypesTables:11]Ref_Structure:6=<>ref_soc_active)
		
		ORDER BY:C49([TypesTables:11]; [TypesTables:11]TT_Libellé:4; >)
End case 