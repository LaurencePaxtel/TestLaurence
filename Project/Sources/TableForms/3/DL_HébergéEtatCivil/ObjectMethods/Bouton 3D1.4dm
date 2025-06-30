If (Form event code:C388=Sur clic:K2:4)
	If (va_IDT_Typ1<="")
		StrAlerte(30; "")
	Else 
		vb_NewEtC:=True:C214
		vb_EtCivil:=True:C214
		vb_Valider:=True:C214
		x_IDTG_1:=rIDTG_1
		x_IDTG_2:=rIDTG_2
		CANCEL:C270
	End if 
End if 