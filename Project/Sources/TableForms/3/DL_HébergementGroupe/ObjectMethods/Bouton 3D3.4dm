If (Size of array:C274(<>ta_GpClé)>0)
	If (<>ta_GpClé>0)
		If (<>te_GpCheck{<>ta_GpClé}=1)
			BEEP:C151
			If (i_Confirmer("Retirer pour aujourd'hui de la réservation par groupe:  "+<>ta_GpClé{<>ta_GpClé}))
				<>te_GpCheck{<>ta_GpClé}:=0
				SET WINDOW TITLE:C213(F_HébergementGroupeTitre(va_GPNom))
			End if 
		End if 
	Else 
		StrAlerte(3; "")
	End if 
End if 
