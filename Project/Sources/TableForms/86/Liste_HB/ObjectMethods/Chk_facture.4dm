Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (Chk_facture)
			Chk_tous:=False:C215
			Chk_non_facture:=False:C215
		End if 
		
		FAC_Get_Records
End case 
