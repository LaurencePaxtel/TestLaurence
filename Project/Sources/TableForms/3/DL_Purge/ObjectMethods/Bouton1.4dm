//Script b_115
CONFIRM:C162("Confirmez vous l'affectation '115' aux fiches d'hébergement voulues !")
If (OK=1)
	MESSAGES ON:C181
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FamGroupe:102="")
	MultiSoc_Filter(->[HeberGement:5])
	If (Records in selection:C76([HeberGement:5])>0)
		READ WRITE:C146([HeberGement:5])
		APPLY TO SELECTION:C70([HeberGement:5]; [HeberGement:5]HG_FamGroupe:102:="115")
		UNLOAD RECORD:C212([HeberGement:5])
		READ ONLY:C145([HeberGement:5])
	End if 
End if 