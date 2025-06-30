If (vl_SP_Reference>0)
	If (F_Tab_Pop("Lieu de naissance"; -><>ta_SIAO_NeLeLieu; ->va_SP_NeLeLieu))
		If (F_SIAO_Var_SP(10; vl_SP_Reference; Field:C253(->[SIAO_Personnes:51]Sp_Lieu_de_naissance_Ville:17); ->va_SP_NeLeLieu; ta_SP_Nom))
		End if 
	End if 
End if 