If (vl_SP_Reference>0)
	If (F_Tab_Pop("Endettement"; -><>ta_SIAO_Dette; ->va_Ss_DT_Intitule2_2))
		If (F_SIAO_Var_SsDT(10; vl_Ss_DT_Reference2_2; Field:C253(->[SIAO_Situations:52]Ss_Intitule:9); ->va_Ss_DT_Intitule2_2; ta_SP_Nom))
		End if 
	End if 
End if 