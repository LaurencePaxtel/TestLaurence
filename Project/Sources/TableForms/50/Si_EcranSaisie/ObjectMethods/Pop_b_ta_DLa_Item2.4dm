If (vl_SP_Reference>0)
	If (F_Tab_Pop("Titre de séjour"; -><>ta_SIAO_TitreSej; ->va_Ss_DLa_Intitule2))
		If (F_SIAO_Var_SsDL(10; vl_Ss_DLa_Reference2; Field:C253(->[SIAO_Situations:52]Ss_Intitule:9); ->va_Ss_DLa_Intitule2; ta_SP_Nom))
		End if 
	End if 
End if 