//Script b_VoirSel
If (Size of array:C274(<>te_FMGrpCK)>0)
	If (<>te_FMGrpCK{1}=1)
		For ($ii; 1; Size of array:C274(<>te_FMGrpCK))
			<>te_FMGrpCK{$ii}:=0
		End for 
	Else 
		For ($ii; 1; Size of array:C274(<>te_FMGrpCK))
			<>te_FMGrpCK{$ii}:=1
		End for 
	End if 
End if 