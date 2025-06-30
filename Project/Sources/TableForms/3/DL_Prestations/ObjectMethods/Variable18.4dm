If (Form event code:C388=Sur clic:K2:4)
	If ([HeBerge:4]HB_ReferenceID:1>0)
		If ([RenseiGnements:20]RG_RéférenceID:1>0)
			If ([HeBerge:4]HB_ReferenceID:1=[RenseiGnements:20]RG_HB_ID:2)
				vl_RéfU_HBB:=[HeBerge:4]HB_ReferenceID:1
				<>Vl_RefUfich:=[RenseiGnements:20]RG_RéférenceID:1
				READ WRITE:C146([RenseiGnements:20])
				If (i_NonVerrou(->[RenseiGnements:20]))
					If (i_Confirmer("Confirmez-vous la suppression ?"))
						DELETE RECORD:C58([RenseiGnements:20])
					End if 
				End if 
				READ ONLY:C145([RenseiGnements:20])
				
				P_HébergementRGFind(vl_RéfU_HBB)
			Else 
				ALERT:C41("Veuillez sélectionner une ligne dans liste et prestations !")
			End if 
		Else 
			StrAlerte(18; "")
		End if 
	Else 
		StrAlerte(3; "")
	End if 
End if 