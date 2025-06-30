If (Form event code:C388=Sur clic:K2:4)
	//Etat civil
	$vl_Fenetre:=i_FenêtreNo(357; 399; 5; "Etat Civil"; 4; "")
	DIALOG:C40([DiaLogues:3]; "DL_TabEtatCivil")
	CLOSE WINDOW:C154($vl_Fenetre)
	
End if 