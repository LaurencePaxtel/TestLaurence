If (Form event code:C388=Sur clic:K2:4)
	If ([ReferenceUnique:2]RU_Fichier:2>"")
		If (i_Confirmer("Suppression de la fiche sélectionnée !"))
			READ WRITE:C146([ReferenceUnique:2])
			If (i_NonVerrou(->[ReferenceUnique:2]))
				DELETE RECORD:C58([ReferenceUnique:2])
				UNLOAD RECORD:C212([ReferenceUnique:2])
				REDRAW WINDOW:C456
			End if 
			READ ONLY:C145([ReferenceUnique:2])
		End if 
	Else 
		StrAlerte(22; "")
	End if 
End if 