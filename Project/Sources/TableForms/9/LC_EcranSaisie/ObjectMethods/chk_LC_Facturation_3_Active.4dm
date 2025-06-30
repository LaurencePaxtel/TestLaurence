Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		If (chk_LC_Facturation_1_Active=False:C215) & (chk_LC_Facturation_2_Active=False:C215) & (chk_LC_Facturation_3_Active=False:C215)
			chk_LC_Facturation_1_Active:=True:C214
		End if 
		
		[LesCentres:9]LC_Facturation_3_Active:83:=chk_LC_Facturation_3_Active
End case 