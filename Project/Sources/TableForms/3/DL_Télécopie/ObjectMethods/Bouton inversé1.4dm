If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(tl_CTSél)>0)
		If (ta_CTNom>0)
			Rec_FaxFamille(2; ->[DiaLogues:3]DL_Date:2; ->Vb_JouNuit; ->Vb_Valide; tl_CTSél)
		Else 
			Rec_FaxFamille(2; ->[DiaLogues:3]DL_Date:2; ->Vb_JouNuit; ->Vb_Valide; 0)
		End if 
	End if 
End if 