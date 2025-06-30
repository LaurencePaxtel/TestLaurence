//Script b_VoirSel

If (Size of array:C274(<>te_GpP_Check)>0)
	$kk:=Num:C11(Not:C34(<>te_GpP_Check{1}=1))
	For ($ii; 1; Size of array:C274(<>te_GpP_Check))
		<>te_GpP_Check{$ii}:=$kk
	End for 
	va_GPmembres:=F_HébergementGroupeProlong([GrouPe:36]GP_Intitulé:4)
End if 