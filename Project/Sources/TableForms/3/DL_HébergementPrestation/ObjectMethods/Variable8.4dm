If ([RenseiGnements:20]RG_RéférenceID:1>0)
	<>Vl_RefUfich:=[RenseiGnements:20]RG_RéférenceID:1
	READ WRITE:C146([RenseiGnements:20])
	If (i_NonVerrou(->[RenseiGnements:20]))
		If (i_Confirmer("Confirmez-vous la suppression ?"))
			DELETE RECORD:C58([RenseiGnements:20])
		End if 
	End if 
	READ ONLY:C145([RenseiGnements:20])
	P_HébergementRGFindS(vl_RéfU_HBB)
Else 
	StrAlerte(18; "")
End if 