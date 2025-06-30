If (Size of array:C274(<>ta_GpClé)>0)
	BEEP:C151
	If (i_Confirmer("Remise à zéro de la réservation par groupe ?"))
		If (Size of array:C274(<>te_GpCheck)>0)
			For ($ii; 1; Size of array:C274(<>te_GpCheck))
				<>te_GpCheck{$ii}:=0
			End for 
		End if 
		SET WINDOW TITLE:C213(F_HébergementGroupeTitre(va_GPNom))
	End if 
End if 