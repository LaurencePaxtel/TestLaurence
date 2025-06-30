If (vl_SP_Reference>0)
	If (F_Tab_Pop("Accueil en collectif"; -><>ta_SIAO_AccueilCol; ->va_Ss_BSc_Intitule1))
		If (F_SIAO_Var_SsBS(10; vl_Ss_BSc_Reference1; Field:C253(->[SIAO_Situations:52]Ss_Intitule:9); ->va_Ss_BSc_Intitule1; ta_SP_Nom))
		End if 
	End if 
End if 