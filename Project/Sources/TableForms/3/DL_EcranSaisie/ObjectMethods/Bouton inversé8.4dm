If (Size of array:C274(<>tb_RubObli)>0)
	$vb_OK:=False:C215
	If (<>tb_RubObli{1})
		$vb_OK:=False:C215
	Else 
		$vb_OK:=True:C214
	End if 
	<>vb_RubObli:=Num:C11($vb_OK)
	For ($ii; 1; Size of array:C274(<>tb_RubObli))
		<>tb_RubObli{$ii}:=$vb_OK
	End for 
End if 