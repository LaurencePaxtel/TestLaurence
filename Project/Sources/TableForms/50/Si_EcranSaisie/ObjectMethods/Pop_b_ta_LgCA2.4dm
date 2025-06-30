If (vl_SP_Reference>0)
	
	If (F_Tab_Pop("Logement ou Hébergement actuel"; -><>ta_SIAO_LogActuel; ->va_Ss_LGa_Intitule2))
		If (F_SIAO_Var_SsLG(10; vl_Ss_LGa_Reference2; Field:C253(->[SIAO_Situations:52]Ss_Intitule:9); ->va_Ss_LGa_Intitule2; ta_SP_Nom))
		End if 
	End if 
End if 


