Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (Chk_tous)
			Chk_facture:=False:C215
			Chk_non_facture:=False:C215
		End if 
		
		FAC_P_Get_Records
		
End case 
