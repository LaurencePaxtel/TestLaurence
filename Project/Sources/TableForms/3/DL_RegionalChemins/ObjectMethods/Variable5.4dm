If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(<>tt_T_CheminsRegionaux)>0)
		If (<>tt_T_CheminsRegionaux>0)
			If (i_Confirmer("Supprimer le chemin : "+<>tt_T_CheminsRegionaux{<>tt_T_CheminsRegionaux}))
				DELETE FROM ARRAY:C228(<>tt_T_CheminsRegionaux; <>tt_T_CheminsRegionaux)
				If (<>tt_T_CheminsRegionaux>Size of array:C274(<>tt_T_CheminsRegionaux))
					<>tt_T_CheminsRegionaux:=Size of array:C274(<>tt_T_CheminsRegionaux)
				End if 
				vt_CheminRepertoire:=<>tt_T_CheminsRegionaux{<>tt_T_CheminsRegionaux}
			End if 
		Else 
			ALERT:C41("Aucune ligne sélectionnée !")
		End if 
	End if 
End if 