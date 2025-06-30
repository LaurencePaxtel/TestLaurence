//Script b_Voir
If (Form event code:C388=Sur clic:K2:4)
	i_Message("Recherche…")
	ta_TrancheColEtatCivil:=0
	QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_HGRupture)
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; >; *)
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >; *)
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_DateNéLe:24; >)
	vt_ColRéf_Libellé:=String:C10(Size of array:C274(tl_HGRupture))+" fiche(s)"+"  pour  "+String:C10(vL_NbFichesRupture)+" personne(s) #"
	
	CLOSE WINDOW:C154
	
	
End if 
