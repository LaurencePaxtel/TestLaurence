// Method [DiaLogues].DL_EcranSaisie.LB  
Case of 
	: (Form event code:C388=Sur nouvelle sélection:K2:29) | (Form event code:C388=Sur clic:K2:4)
		TableChamps(3; <>te_RubTri)
		TableChamps(3; <>ta_RubNom)
		TableChamps(3; <>ta_RubNomNew)
		TableChamps(3; <>tb_RubVis)
		TableChamps(3; <>tb_RubSais)
		TableChamps(3; <>tb_RubMod)
		TableChamps(3; <>tb_RubObli)
		TableChamps(3; <>tb_RubPopVis)
		TableChamps(3; <>tb_RubTrans)
		TableChamps(3; <>te_RubOrdre)
		TableChamps(3; <>ta_RubAlert)
End case 