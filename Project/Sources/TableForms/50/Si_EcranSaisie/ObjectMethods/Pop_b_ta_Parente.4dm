If (vl_SP_Reference>0)
	If (F_Tab_Pop("Parenté"; -><>ta_SIAO_Parente; ->va_SP_Parente))
		If (F_SIAO_Var_SP(10; vl_SP_Reference; Field:C253(->[SIAO_Personnes:51]Sp_Parente_plus:22); ->va_SP_Parente; ta_SP_Nom))
		End if 
	End if 
End if 