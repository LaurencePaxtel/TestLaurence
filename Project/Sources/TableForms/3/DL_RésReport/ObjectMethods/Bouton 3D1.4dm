MESSAGES ON:C181
QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Réservation:91=True:C214)
QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_NuitReste:95>0)
FIRST RECORD:C50([HeberGement:5])
If (Records in selection:C76([HeberGement:5])>0)
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22)
End if 

va_FichesNb:=String:C10(Records in selection:C76([HeberGement:5]); "## ### ##0")+" / "+String:C10(vl_itemNb; "## ### ##0")+" fiche(s)"
//vl_itemNb:=Enregistrements trouves([HéberGement])