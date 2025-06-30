If (Size of array:C274(te_Sel2)>0)
	
	If (te_Sel2{1}=1)
		$ij:=0
	Else 
		$ij:=1
	End if 
	
	For ($ii; 1; Size of array:C274(te_Sel2))
		te_Sel2{$ii}:=$ij
	End for 
	
End if 