If (i_Confirmer("Mise à jour des données ?"))
	P_TauxPresentation(1; 1)
	CHART_DessineLeGraphe(vl_LeGraphe1; ->vl_IDLeGraphe1; 6; 1)
	CHART_DessineLeGraphe(vl_LeGraphe2; ->vl_IDLeGraphe2; 6; 2)
	CHART_DessineLeGraphe(vl_LeGraphe3; ->vl_IDLeGraphe3; 6; 3)
	
	//P_TauxPresentation (10)  `Export
	
	
End if 