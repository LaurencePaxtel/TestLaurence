If (Form event code:C388=Sur clic:K2:4)
	If (vb_Ville=True:C214)
		vb_Ville:=False:C215
	Else 
		vb_Ville:=True:C214
	End if 
	va_Ville:=("Ville"*Num:C11(vb_Ville=True:C214))+("Metro"*Num:C11(vb_Ville=False:C215))
End if 