If (Size of array:C274(<>tb_RubVis)>0)
	$vb_OK:=False:C215
	If (<>tb_RubVis{1})
		$vb_OK:=False:C215
	Else 
		$vb_OK:=True:C214
	End if 
	
	<>vb_RubVis:=Num:C11($vb_OK)
	For ($ii; 1; Size of array:C274(<>tb_RubVis))
		<>tb_RubVis{$ii}:=$vb_OK
	End for 
End if 