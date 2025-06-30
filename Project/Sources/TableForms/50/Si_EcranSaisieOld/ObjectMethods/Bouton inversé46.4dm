If (vl_SP_Reference>0)
	If (F_Tab_Pop("Crédit"; -><>ta_SIAO_Credit; ->va_Ss_DT_Intitule4))
		If (F_SIAO_Var_SsDT(10; vl_Ss_DT_Reference4; Field:C253(->[SIAO_Situations:52]Ss_Intitule:9); ->va_Ss_DT_Intitule4; ta_SP_Nom))
		End if 
	End if 
End if 