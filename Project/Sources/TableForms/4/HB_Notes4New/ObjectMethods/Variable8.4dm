If (Form event code:C388=Sur clic:K2:4)
	
	If (Modified record:C314([HeBerge:4])) | (Modified record:C314([Adresses:53]))
		Quit_HBNotes
		
		// Modifié par : Scanu Rémy (22/02/2023)
		If (Ok=1)
			SAVE RECORD:C53([HeBerge:4])
			SAVE RECORD:C53([Adresses:53])
		End if 
		
	Else 
		CANCEL:C270
	End if 
	
End if 