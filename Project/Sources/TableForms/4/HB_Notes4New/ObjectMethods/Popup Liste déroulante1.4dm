Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		ARRAY TEXT:C222(note_at; 0)
		
		COLLECTION TO ARRAY:C1562(Form:C1466.typeNote.extract("lib"); note_at)
		
		INSERT IN ARRAY:C227(note_at; 1)
		note_at{1}:="Tous"
		
		note_at{0}:="Type de note"
	: (Form event code:C388=Sur données modifiées:K2:15)
		POST OUTSIDE CALL:C329(Current process:C322)
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 