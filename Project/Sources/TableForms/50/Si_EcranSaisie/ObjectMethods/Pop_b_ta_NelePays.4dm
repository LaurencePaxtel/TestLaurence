
If (vl_SP_Reference>0)
	If (F_Tab_Pop("Pays de naissance"; -><>ta_SIAO_NeLePays; ->va_SP_NeLePays))
		If (F_SIAO_Var_SP(10; vl_SP_Reference; Field:C253(->[SIAO_Personnes:51]Sp_Lieu_de_naissance_pays:18); ->va_SP_NeLePays; ta_SP_Nom))
		End if 
	End if 
End if 