//%attributes = {}
C_TEXT:C284($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

If ($1>"")
	vb_RecHéb:=False:C215
	va_RH_Typ1:=""
	va_RH_Typ2:=""
	vl_RH_RéfID:=0
	READ WRITE:C146([DiaLogues:3])
	FORM SET INPUT:C55([DiaLogues:3]; "DL_CentresSIAO")
	$vl_Fenetre:=i_FenêtreNo(786; 543; 16; "Sélectionner un centre"; 12; "Quit_Simple")
	ADD RECORD:C56([DiaLogues:3]; *)
	CLOSE WINDOW:C154($vl_Fenetre)
	If (vb_RecHéb)
		$2->:=vl_RH_RéfID
		$3->:=va_RH_Typ1
	End if 
End if 