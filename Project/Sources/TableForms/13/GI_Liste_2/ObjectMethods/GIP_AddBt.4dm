//Script b_AdCEL

If (User in group:C338(Current user:C182; <>Groupe_ADMIN)) | (User in group:C338(Current user:C182; <>Groupe_DEVELOP)) | (User in group:C338(Current user:C182; <>Groupe_Coordinateur))
	
	//FORM SET INPUT([GIP];"aEcranSaisie_2")
	ADD RECORD:C56([GIP:13]; *)
	If (b_Val=1)
		ADD TO SET:C119([GIP:13]; "E_EnCours")
	End if 
	USE SET:C118("E_EnCours")
	ORDER BY:C49([GIP:13]; [GIP:13]GI_Nom:5; >)
	FIRST RECORD:C50([GIP:13])
Else 
	ALERT:C41("Vous ne disposez pas des privilèges d'accès à cette fonction.")
End if 