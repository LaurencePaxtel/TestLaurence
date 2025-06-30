If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(<>tt_T_CheminsRegionaux)>0)
		If (<>tt_T_CheminsRegionaux>0)
			If (vt_CheminRepertoire>"")
				<>tt_T_CheminsRegionaux{<>tt_T_CheminsRegionaux}:=vt_CheminRepertoire
			Else 
				ALERT:C41("Le chemin est vide !")
			End if 
		Else 
			ALERT:C41("Aucune ligne sélectionnée !")
		End if 
	End if 
End if 