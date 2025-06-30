If (vl_SP_Reference>0)
	If (F_Tab_Pop("Papiers administratifs"; -><>ta_SIAO_Papier; ->va_SP_Papier))
		If (F_SIAO_Var_SP(10; vl_SP_Reference; Field:C253(->[SIAO_Personnes:51]Sp_Carte_d_identite_no:26); ->va_SP_Papier; ta_SP_Nom))
		End if 
	End if 
End if 