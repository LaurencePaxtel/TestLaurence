//Script b_VoirSel
If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(te_EnumEx_Check)>0)
		If (te_EnumEx_Check{1}=1)
			For ($ii; 1; Size of array:C274(te_EnumEx_Check))
				te_EnumEx_Check{$ii}:=0
			End for 
		Else 
			For ($ii; 1; Size of array:C274(te_EnumEx_Check))
				te_EnumEx_Check{$ii}:=1
			End for 
		End if 
	End if 
End if 