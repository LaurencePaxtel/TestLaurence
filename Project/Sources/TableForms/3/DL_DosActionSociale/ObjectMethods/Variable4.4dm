If ([ActionSociale:26]AA_Référence:1>0)
	READ WRITE:C146([ActionSociale:26])
	If (i_NonVerrou(->[ActionSociale:26]))
		If (i_Confirmer("Confirmez-vous la suppression"))
			DELETE RECORD:C58([ActionSociale:26])
			REDRAW:C174([ActionSociale:26])
		End if 
		UNLOAD RECORD:C212([ActionSociale:26])
	End if 
	READ WRITE:C146([ActionSociale:26])
Else 
	StrAlerte(22; "")
End if 