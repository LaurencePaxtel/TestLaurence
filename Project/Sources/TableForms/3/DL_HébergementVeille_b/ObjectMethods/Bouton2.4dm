If (Form event code:C388=Sur clic:K2:4)
	va_Titre:="Critères de recherche par tranches d'âges"
	$vl_Fenetre:=i_FenêtreNo(466; 252; 5; va_Titre; 4; "")
	DIALOG:C40([DiaLogues:3]; "DL_RecTrAges")
	CLOSE WINDOW:C154($vl_Fenetre)
End if 