If (vl_SP_Reference>0)
	If (F_Tab_Pop("Cas spécific"; -><>ta_SIAO_CasSpec; ->va_SP_CasSpecific))
		If (F_SIAO_Var_SP(10; vl_SP_Reference; Field:C253(->[SIAO_Personnes:51]Sp_CasSpecific:38); ->va_SP_CasSpecific; ta_SP_Nom))
		End if 
	End if 
End if 