
If (vl_SP_Reference>0)
	If (F_UnEspaceNote(vt_Ss_DLc_Referent2; "Labellisé accord collectif : Réf."; True:C214))
		vt_Ss_DLc_Referent2:=vt_UnTexte
		If (F_SIAO_Var_SsDL(10; vl_Ss_DLc_Reference2; Field:C253(->[SIAO_Situations:52]Ss_Note:30); ->vt_Ss_DLc_Referent2; ta_SP_Nom))
		End if 
	End if 
End if 