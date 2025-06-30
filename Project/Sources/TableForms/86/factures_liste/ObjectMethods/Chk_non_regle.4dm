Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (Chk_non_regle=True:C214)
			Chk_regle:=False:C215
			Chk_tous:=False:C215
		Else 
			Chk_tous:=True:C214
		End if 
		
		FAC_Get_Liste_Factures
End case 
