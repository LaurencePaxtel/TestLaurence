If (ta_MRLib<9)
	READ WRITE:C146([ActionSociale:26])
	FORM SET INPUT:C55([ActionSociale:26]; "AA_EcranSaisie")
	$vl_Fenetre:=i_FenêtreNo(358; 357; 4; Nouvelle actions sociale; 3; "")
	ADD RECORD:C56([ActionSociale:26]; *)
	CLOSE WINDOW:C154($vl_Fenetre)
	READ ONLY:C145([ActionSociale:26])
Else 
	ALERT:C41("Veuillez sélectionner le domaine de l'action !")
End if 