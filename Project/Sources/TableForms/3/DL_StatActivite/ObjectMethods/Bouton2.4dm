If (Form event code:C388=Sur clic:K2:4)
	C_LONGINT:C283($vl_Fenetre)
	$vl_Fenetre:=i_FenêtreNo(357; 429; 5; "Centres"; 4; "")
	DIALOG:C40([DiaLogues:3]; "DL_TabCritèreCentre2")
	CLOSE WINDOW:C154($vl_Fenetre)
	
	
End if 

