//Script b_VoirSel
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
	SET WINDOW TITLE:C213(F_HébergementGroupeTitre(va_GPNom))
	
End if 