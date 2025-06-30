//Script b_115
CONFIRM:C162("Confirmez vous la renumérotation des hébergements  ?")
If (OK=1)
	MESSAGES ON:C181
	vl_ii:=0
	READ WRITE:C146([HeberGement:5])
	ALL RECORDS:C47([HeberGement:5])
	MultiSoc_Filter(->[HeberGement:5])
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; >; *)
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; >)
	FIRST RECORD:C50([HeberGement:5])
	APPLY TO SELECTION:C70([HeberGement:5]; wUut_MàjNoHébergement)
	READ ONLY:C145([HeberGement:5])
	
	vl_ii:=vl_ii+1
	READ WRITE:C146([ReferenceUnique:2])
	QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=Table name:C256(->[HeberGement:5]))
	If (Records in selection:C76([ReferenceUnique:2])=1)
		Repeat 
			LOAD RECORD:C52([ReferenceUnique:2])
		Until (Not:C34(Locked:C147([ReferenceUnique:2])))
		[ReferenceUnique:2]RU_Numero:3:=vl_ii
		SAVE RECORD:C53([ReferenceUnique:2])
		UNLOAD RECORD:C212([ReferenceUnique:2])
	Else 
		If (Records in selection:C76([ReferenceUnique:2])>1)
			DELETE SELECTION:C66([ReferenceUnique:2])
		End if 
		CREATE RECORD:C68([ReferenceUnique:2])
		MultiSoc_Init_Structure(->[ReferenceUnique:2])
		[ReferenceUnique:2]RU_Fichier:2:=Table name:C256(->[HeberGement:5])
		[ReferenceUnique:2]RU_Numero:3:=vl_ii
		[ReferenceUnique:2]RU_ValeurApha:4:=""
		SAVE RECORD:C53([ReferenceUnique:2])
		UNLOAD RECORD:C212([ReferenceUnique:2])
	End if 
	UNLOAD RECORD:C212([ReferenceUnique:2])
	READ ONLY:C145([ReferenceUnique:2])
	MESSAGES OFF:C175
End if 