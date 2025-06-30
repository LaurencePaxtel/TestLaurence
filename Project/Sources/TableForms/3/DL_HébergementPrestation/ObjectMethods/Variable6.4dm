

If (vl_RéfU_HBB>0)
	READ WRITE:C146([RenseiGnements:20])
	FORM SET INPUT:C55([RenseiGnements:20]; "RG_EcranSaisie")
	$vl_Fenetre:=i_FenêtreNo(632; 270; 4; va_IdentitS+" : "+"Fiche demande : nouveau"; 4; "")
	ADD RECORD:C56([RenseiGnements:20]; *)
	UNLOAD RECORD:C212([RenseiGnements:20])
	CLOSE WINDOW:C154($vl_Fenetre)
	READ ONLY:C145([RenseiGnements:20])
	P_HébergementRGFindS(vl_RéfU_HBB)
Else 
	StrAlerte(2; "")
End if 