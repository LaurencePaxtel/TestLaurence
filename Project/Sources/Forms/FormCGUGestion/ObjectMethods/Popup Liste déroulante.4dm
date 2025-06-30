Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		ARRAY TEXT:C222(structure_at; 0)
		
		COLLECTION TO ARRAY:C1562(ds:C1482.Structures.all().toCollection(); structure_at; "STRC_Nom")
		
		INSERT IN ARRAY:C227(structure_at; 1)
		structure_at{1}:="Tous"
		
		structure_at{0}:="Sélectionner une structure"
	: (Form event code:C388=Sur données modifiées:K2:15)
		POST OUTSIDE CALL:C329(Current process:C322)
End case 