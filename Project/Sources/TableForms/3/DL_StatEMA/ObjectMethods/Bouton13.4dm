//Choix d'impressions
If (Form event code:C388=Sur clic:K2:4)
	$vl_Fenetre:=i_FenêtreNo(352; 231; 5; "Impressions"; 4; "")
	DIALOG:C40([DiaLogues:3]; "DL_StatChoixPrintDirection")
	CLOSE WINDOW:C154($vl_Fenetre)
End if 
