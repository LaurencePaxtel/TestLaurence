If (Size of array:C274(te_Sel4)>0)
	If (te_Sel4{1}=1)
		$ij:=0
	Else 
		$ij:=1
	End if 
	For ($ii; 1; Size of array:C274(te_Sel4))
		te_Sel4{$ii}:=$ij
	End for 
End if 