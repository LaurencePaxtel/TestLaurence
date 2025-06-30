If (Form event code:C388=Sur clic:K2:4)
	MESSAGES ON:C181
	va_CodEE:=Request:C163("Code de l'énumération :"; "040/@"; "Mise à jour"; "Annuler")
	If (OK=1)
		If (i_Confirmer("Reconstruction du code des énumération de type : "+va_CodEE))
			READ WRITE:C146([TAbles:12])
			QUERY:C277([TAbles:12]; [TAbles:12]TB_Code:5=va_CodEE)
			If (Records in selection:C76([TAbles:12])>0)
				APPLY TO SELECTION:C70([TAbles:12]; wUut_CléEnum)
			End if 
			UNLOAD RECORD:C212([TAbles:12])
			READ ONLY:C145([TAbles:12])
		End if 
	End if 
	MESSAGES OFF:C175
End if 