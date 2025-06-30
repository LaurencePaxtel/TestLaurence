If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(ta_UserNom)>0)
		SORT ARRAY:C229(ta_UserNom; tl_UserRéf; te_UserEtat; >)
	End if 
End if 