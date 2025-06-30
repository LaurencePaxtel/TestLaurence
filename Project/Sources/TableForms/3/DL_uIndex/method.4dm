If (Form event code:C388=Sur double clic:K2:5)
	If (Size of array:C274(ta_IndexChamp)>0)
		If (ta_IndexChamp>0)
			If (te_IndexFichier{ta_IndexChamp}>0)
				If (te_IndexCheck{ta_IndexChamp}>0)
					te_IndexCheck{ta_IndexChamp}:=0
				Else 
					te_IndexCheck{ta_IndexChamp}:=1
				End if 
			End if 
		End if 
	End if 
End if 