If (vl_SP_Reference>0)
	If (F_Tab_Pop("Aide financière"; -><>ta_SIAO_BesAidF; ->va_Ss_DLb_Intitule1))
		If (F_SIAO_Var_SsDL(10; vl_Ss_DLb_Reference1; Field:C253(->[SIAO_Situations:52]Ss_Intitule:9); ->va_Ss_DLb_Intitule1; ta_SP_Nom))
		End if 
	End if 
End if 