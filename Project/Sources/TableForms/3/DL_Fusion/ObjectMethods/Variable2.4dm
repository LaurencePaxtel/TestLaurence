If (Form event code:C388=Sur données modifiées:K2:15)
	If (va_IDT_Typ1>"") & (va_IDT_Typ2>"")
		OBJECT SET ENABLED:C1123(b_Fuse; True:C214)
	Else 
		OBJECT SET ENABLED:C1123(b_Fuse; False:C215)
	End if 
End if 