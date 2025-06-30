Case of 
	: (Form event code:C388=Sur clic:K2:4)
		FORM SET INPUT:C55([TypesTables:11]; "TT_EcranSaisie")
		
		ADD RECORD:C56([TypesTables:11]; *)
		ALL RECORDS:C47([TypesTables:11])
		
		ORDER BY:C49([TypesTables:11]; [TypesTables:11]TT_Libellé:4; >)
End case 