//Script b_VoirSel
If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(ta_xGroupe)>0)
		If (te_xGroupe{1}=1)
			For ($ii; 1; Size of array:C274(te_xGroupe))
				te_xGroupe{$ii}:=0
			End for 
		Else 
			For ($ii; 1; Size of array:C274(te_xGroupe))
				te_xGroupe{$ii}:=1
			End for 
		End if 
	End if 
End if 