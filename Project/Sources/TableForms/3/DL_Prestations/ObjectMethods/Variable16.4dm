If (Form event code:C388=Sur clic:K2:4)
	
	If ([HeBerge:4]HB_ReferenceID:1>0)
		vl_RéfU_HBB:=[HeBerge:4]HB_ReferenceID:1
		va_Identité:=[HeBerge:4]HB_Nom:3+" "+[HeBerge:4]HB_Prénom:4+" "+String:C10([HeBerge:4]HB_DateNéLe:5; 7)
		READ WRITE:C146([RenseiGnements:20])
		FORM SET INPUT:C55([RenseiGnements:20]; "RG_EcranSaisie")
		$vl_Fenetre:=i_FenêtreNo(632; 241; 4; va_Identité+" : "+"Fiche demande : nouveau"; 1; "")
		ADD RECORD:C56([RenseiGnements:20]; *)
		UNLOAD RECORD:C212([RenseiGnements:20])
		CLOSE WINDOW:C154($vl_Fenetre)
		READ ONLY:C145([RenseiGnements:20])
		P_HébergementRGFind(vl_RéfU_HBB)
	Else 
		StrAlerte(3; "")
	End if 
End if 