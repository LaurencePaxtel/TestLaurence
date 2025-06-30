If (Size of array:C274(<>tb_RubMod)>0)
	$vb_OK:=False:C215
	If (<>tb_RubMod{1})
		$vb_OK:=False:C215
	Else 
		$vb_OK:=True:C214
	End if 
	<>vb_RubMod:=Num:C11($vb_OK)
	For ($ii; 1; Size of array:C274(<>tb_RubMod))
		<>tb_RubMod{$ii}:=$vb_OK
	End for 
End if 