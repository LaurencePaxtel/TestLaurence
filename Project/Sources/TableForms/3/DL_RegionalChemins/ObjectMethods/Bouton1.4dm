If (Form event code:C388=Sur clic:K2:4)
	If (vt_CheminRepertoire>"")
		INSERT IN ARRAY:C227(<>tt_T_CheminsRegionaux; Size of array:C274(<>tt_T_CheminsRegionaux)+1)
		<>tt_T_CheminsRegionaux{Size of array:C274(<>tt_T_CheminsRegionaux)}:=vt_CheminRepertoire
	Else 
		ALERT:C41("Veuillez saisir un chemin !")
	End if 
End if 
