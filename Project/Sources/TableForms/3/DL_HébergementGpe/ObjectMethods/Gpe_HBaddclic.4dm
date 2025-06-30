If (Size of array:C274(<>te_GpCheck)>0)
	
	If (<>te_GpCheck{1}=1)
		
		For ($ii; 1; Size of array:C274(<>te_GpCheck))
			<>te_GpCheck{$ii}:=0
		End for 
		
	Else 
		
		For ($ii; 1; Size of array:C274(<>te_GpCheck))
			<>te_GpCheck{$ii}:=1
		End for 
		
	End if 
	
	va_GPmembres:=F_HébergementGroupeTitre([GrouPe:36]GP_Intitulé:4)
End if 