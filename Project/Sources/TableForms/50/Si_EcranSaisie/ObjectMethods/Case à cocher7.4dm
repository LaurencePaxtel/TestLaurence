If (Form event code:C388=Sur clic:K2:4)
	If (vl_SP_Reference>0)
		vb_Ss_SPA_CheckB_2:=(vl_Ss_SPA_CheckB_2=1)
		If (F_SIAO_Var_SsSP(10; vl_Ss_SPA_Reference2; Field:C253(->[SIAO_Situations:52]Ss_Check_2:12); ->vb_Ss_SPA_CheckB_2; ta_SP_Nom))
		End if 
	End if 
End if 