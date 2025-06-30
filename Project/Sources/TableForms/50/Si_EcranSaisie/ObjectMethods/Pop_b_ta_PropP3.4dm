


If (vl_SP_Reference>0)
	If (F_Tab_Pop("Proposition"; -><>ta_SIAO_Orienter; ->va_Ss_PPb_Intitule3))
		If (F_SIAO_Var_SsPP(10; vl_Ss_PPb_Reference3; Field:C253(->[SIAO_Situations:52]Ss_Intitule:9); ->va_Ss_PPb_Intitule3; ta_SP_Nom))
		End if 
	End if 
End if 