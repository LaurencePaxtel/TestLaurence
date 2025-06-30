//Script b_VoirSel
If (Form event code:C388=Sur clic:K2:4)
	
	C_LONGINT:C283($ii)
	If (Size of array:C274(ta_LesIndices)>0)
		If (te_LesIndices{1}=1)
			For ($ii; 1; Size of array:C274(ta_LesIndices))
				te_LesIndices{$ii}:=0
			End for 
		Else 
			For ($ii; 1; Size of array:C274(ta_LesIndices))
				te_LesIndices{$ii}:=1
			End for 
		End if 
	End if 
End if 