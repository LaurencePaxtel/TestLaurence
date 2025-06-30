//Script b_VoirSel
If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(te_xSglt)>0)
		If (te_xSglt{1}=1)
			For ($ii; 1; Size of array:C274(te_xSglt))
				te_xSglt{$ii}:=0
			End for 
		Else 
			For ($ii; 1; Size of array:C274(te_xSglt))
				te_xSglt{$ii}:=1
			End for 
		End if 
	End if 
End if 