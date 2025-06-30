//Script b_VoirSel
If (Size of array:C274(ta_CTNom)>0)
	If (tl_CTSél{1}=1)
		For ($ii; 1; Size of array:C274(ta_CTNom))
			tl_CTSél{$ii}:=0
		End for 
	Else 
		For ($ii; 1; Size of array:C274(ta_CTNom))
			tl_CTSél{$ii}:=1
		End for 
	End if 
End if 