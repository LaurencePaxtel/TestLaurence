If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(ta_GroupeNom)>0)
		SORT ARRAY:C229(ta_GroupeNom; tl_GroupeRéf; >)
	End if 
End if 