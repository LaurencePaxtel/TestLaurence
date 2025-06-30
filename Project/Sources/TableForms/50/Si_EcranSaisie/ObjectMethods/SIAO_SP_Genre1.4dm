If (Form event code:C388=Sur clic:K2:4)
	If (vl_SP_Reference>0)
		vb_SP_Genre:=Not:C34(vL_SP_Genre1=1)
		If (F_SIAO_Var_SP(10; vl_SP_Reference; Field:C253(->[SIAO_Personnes:51]Sp_Genre:10); ->vb_SP_Genre; ta_SP_Nom))
		End if 
	End if 
End if 


