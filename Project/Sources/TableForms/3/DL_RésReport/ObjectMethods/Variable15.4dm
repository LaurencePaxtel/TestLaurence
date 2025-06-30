If (Records in selection:C76([HeberGement:5])>0)
	If (i_Confirmer("Confirmez-vous l'annulation du report ?"))
		MESSAGES ON:C181
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Reporté:94=<>va_RepR)
		If (Records in selection:C76([HeberGement:5])>0)
			READ WRITE:C146([HeberGement:5])
			APPLY TO SELECTION:C70([HeberGement:5]; [HeberGement:5]HG_Reporté:94:="")
			READ ONLY:C145([HeberGement:5])
		End if 
	End if 
Else 
	StrAlerte(23; "")
End if 