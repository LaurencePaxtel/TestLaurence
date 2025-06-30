If (Size of array:C274(ta_ValFam)>0)
	If (ta_ValFam>0)
		If (ta_ValFam{0}=ta_ValFam{ta_ValFam})
		Else 
			ta_ValFam{0}:=ta_ValFam{ta_ValFam}
			Rec_TransFamille(3; ->[DiaLogues:3]DL_Date:2; ->Vb_JouNuit; ->Vb_Valide; ta_ValFam)
		End if 
	Else 
		ta_ValFam:=Find in array:C230(ta_ValFam; ta_ValFam{0})
	End if 
End if 