If (Form event code:C388=Sur clic:K2:4)
	va_Titre:="Critères de recherche par réservation"
	$vl_Fenetre:=i_FenêtreNo(466; 252; 5; va_Titre; 4; "")
	DIALOG:C40([DiaLogues:3]; "DL_RecReservation")
	CLOSE WINDOW:C154($vl_Fenetre)
End if 