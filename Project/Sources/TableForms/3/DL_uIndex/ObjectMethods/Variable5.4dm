If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(ta_IndexChamp)>0)
		If (te_IndexCheck{1}>0)
			For ($ii; 1; Size of array:C274(ta_IndexChamp))
				te_IndexCheck{$ii}:=0
			End for 
		Else 
			For ($ii; 1; Size of array:C274(ta_IndexChamp))
				If (te_IndexFichier{$ii}>0)
					te_IndexCheck{$ii}:=1
				End if 
			End for 
		End if 
	End if 
End if 