If (Form event code:C388=Sur clic:K2:4)
	If (vl_SP_Reference>0)
		vb_Ss_DLb_Check3:=(vl_Ss_DLb_Check3=1)
		If (F_SIAO_Var_SsDL(10; vl_Ss_DLb_Reference3; Field:C253(->[SIAO_Situations:52]Ss_Check_1:11); ->vb_Ss_DLb_Check3; ta_SP_Nom))
		End if 
	End if 
End if 