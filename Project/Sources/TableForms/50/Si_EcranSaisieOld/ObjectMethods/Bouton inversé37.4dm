If (vl_SP_Reference>0)
	If (F_Tab_Pop("Type de papiers"; -><>ta_SIAO_TypePapier; ->va_SP_PapierType))
		If (F_SIAO_Var_SP(10; vl_SP_Reference; Field:C253(->[SIAO_Personnes:51]Sp_Carte_de_sejour_nature:28); ->va_SP_PapierType; ta_SP_Nom))
		End if 
	End if 
End if 