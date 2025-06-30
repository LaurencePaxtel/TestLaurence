If (Form event code:C388=Sur clic:K2:4)
	If ([ReferenceUnique:2]RU_Fichier:2>"")
		
		READ WRITE:C146([ReferenceUnique:2])
		If (i_NonVerrou(->[ReferenceUnique:2]))
			If (FORM Get current page:C276=1)
				[ReferenceUnique:2]RU_Numero:3:=vl_Numéro
			Else 
				[ReferenceUnique:2]RU_ValeurApha:4:=va_LibelléValeur
			End if 
			SAVE RECORD:C53([ReferenceUnique:2])
			UNLOAD RECORD:C212([ReferenceUnique:2])
			REDRAW WINDOW:C456
		End if 
		READ ONLY:C145([ReferenceUnique:2])
	End if 
	
	
End if 