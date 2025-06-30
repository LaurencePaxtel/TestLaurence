If (vl_SP_Reference>0)
	If (F_Tab_Pop("Civilité"; -><>ta_SIAO_Civilite; ->va_SP_Civilite))
		If (F_SIAO_Var_SP(10; vl_SP_Reference; Field:C253(->[SIAO_Personnes:51]Sp_Civilite:9); ->va_SP_Civilite; ta_SP_Nom))
		End if 
	End if 
End if 