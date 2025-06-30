If (vl_SP_Reference>0)
	If (F_Tab_Pop("Ressources"; -><>ta_SIAO_Ressource; ->va_Ss_RS_Intitule1))
		If (F_SIAO_Var_SsRS(10; vl_Ss_RS_Reference1; Field:C253(->[SIAO_Situations:52]Ss_Intitule:9); ->va_Ss_RS_Intitule1; ta_SP_Nom))
		End if 
	End if 
End if 