//Script b_MàJEtF 
MESSAGES ON:C181


READ ONLY:C145([HeberGement:5])
QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FamCompo:105>"")
MultiSoc_Filter(->[HeberGement:5])
If (Records in selection:C76([HeberGement:5])>0)
	CONFIRM:C162("M à J  du champ Composition de famille : "+String:C10(Records in selection:C76([HeberGement:5]))+" fiche(s) à modifier")
	If (OK=1)
		P_HG_Famille(-1)
		READ WRITE:C146([HeberGement:5])
		APPLY TO SELECTION:C70([HeberGement:5]; P_HG_FamilleMàJ)
		READ ONLY:C145([HeberGement:5])
	End if 
	
Else 
	ALERT:C41("Aucune fiche dont le champ  Composition Famille soit renseigné.")
End if 