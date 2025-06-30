If (vl_SP_Reference>0)
	If (F_Tab_Pop("Nationalité"; -><>ta_SIAO_Nationalite; ->va_SP_Nationalite))
		If (F_SIAO_Var_SP(10; vl_SP_Reference; Field:C253(->[SIAO_Personnes:51]Sp_Nationalite:23); ->va_SP_Nationalite; ta_SP_Nom))
		End if 
	End if 
End if 