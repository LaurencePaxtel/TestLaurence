Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (Chk_tous)
			Chk_regle:=False:C215
			Chk_non_regle:=False:C215
		Else 
			Chk_regle:=True:C214
		End if 
		
		FAC_Get_Liste_Factures
		
End case 
