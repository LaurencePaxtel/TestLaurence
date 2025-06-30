If (Size of array:C274(<>tb_RubSais)>0)
	$vb_OK:=False:C215
	If (<>tb_RubSais{1})
		$vb_OK:=False:C215
	Else 
		$vb_OK:=True:C214
	End if 
	<>vb_RubSais:=Num:C11($vb_OK)
	For ($ii; 1; Size of array:C274(<>tb_RubSais))
		<>tb_RubSais{$ii}:=$vb_OK
	End for 
End if 