If (Size of array:C274(<>tb_RubTrans)>0)
	If (<>tb_RubTrans{1})
		$vb_OK:=False:C215
	Else 
		$vb_OK:=True:C214
	End if 
	<>vb_RubTrans:=Num:C11($vb_OK)
	For ($ii; 1; Size of array:C274(<>tb_RubTrans))
		<>tb_RubTrans{$ii}:=$vb_OK
	End for 
End if 