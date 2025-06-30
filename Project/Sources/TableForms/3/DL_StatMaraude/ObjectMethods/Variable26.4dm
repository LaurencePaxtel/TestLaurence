If (Size of array:C274(te_Sel1)>0)
	If (te_Sel1{1}=1)
		$ij:=0
	Else 
		$ij:=1
	End if 
	For ($ii; 1; Size of array:C274(te_Sel1))
		te_Sel1{$ii}:=$ij
	End for 
End if 