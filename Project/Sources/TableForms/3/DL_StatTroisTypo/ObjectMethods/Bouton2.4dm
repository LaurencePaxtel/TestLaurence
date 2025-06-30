//Centres
If (Form event code:C388=Sur clic:K2:4)
	$vl_Fenetre:=i_FenêtreNo(357; 399; 5; "Centres"; 4; "")
	DIALOG:C40([DiaLogues:3]; "DL_TroisFoisRienCentre")
	CLOSE WINDOW:C154($vl_Fenetre)
	
End if 