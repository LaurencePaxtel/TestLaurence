If (Size of array:C274(te_Sel3)>0)
	If (te_Sel3{1}=1)
		$ij:=0
	Else 
		$ij:=1
	End if 
	For ($ii; 1; Size of array:C274(te_Sel3))
		te_Sel3{$ii}:=$ij
	End for 
End if 