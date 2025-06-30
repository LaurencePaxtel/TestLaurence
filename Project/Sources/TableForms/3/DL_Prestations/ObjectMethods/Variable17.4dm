If (Form event code:C388=Sur clic:K2:4)
	If ([RenseiGnements:20]RG_RéférenceID:1>0)
		If ([HeBerge:4]HB_ReferenceID:1=[RenseiGnements:20]RG_HB_ID:2)
			vl_RéfU_HBB:=[HeBerge:4]HB_ReferenceID:1
			<>Vl_RefUfich:=[RenseiGnements:20]RG_RéférenceID:1
			READ WRITE:C146([RenseiGnements:20])
			If (i_NonVerrou(->[RenseiGnements:20]))
				FORM SET INPUT:C55([RenseiGnements:20]; "RG_EcranSaisie")
				$vl_Fenetre:=i_FenêtreNo(632; 241; 4; va_Identité+" : "+"Fiche demande : modifier"; 1; "")
				MODIFY RECORD:C57([RenseiGnements:20]; *)
				UNLOAD RECORD:C212([RenseiGnements:20])
				CLOSE WINDOW:C154
			End if 
			READ ONLY:C145([RenseiGnements:20])
			//P_HébergementRGFind (vl_RéfU_HBB)
		Else 
			ALERT:C41("Veuillez sélectionner une ligne dans liste et prestations !")
		End if 
	Else 
		StrAlerte(18; "")
	End if 
End if 
