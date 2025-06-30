If (Size of array:C274(<>tb_RubPopVis)>0)
	For ($ii; 1; Size of array:C274(<>tb_RubPopVis))
		<>tb_RubPopVis{$ii}:=<>tb_RubObli{$ii}
	End for 
	<>vb_RubPopVis:=Num:C11(<>tb_RubPopVis{<>tb_RubPopVis})
End if 