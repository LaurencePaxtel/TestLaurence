Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		ARRAY TEXT:C222(typeNote_at; 0)
		
		COLLECTION TO ARRAY:C1562(Form:C1466.typeNote.extract("lib"); typeNote_at)
		typeNote_at{0}:="Type de note"
End case 